import { Debris, Players, ReplicatedStorage, RunService, Teams } from "@rbxts/services";
import { t } from "@rbxts/t";
import { getFactions } from "server/factions/faction";
import { getTeams } from "server/team_generator/generator_funcs";
import { Avatar } from "shared/avatar";
import { Character } from "shared/avatar/character_types";
import { Handler } from "shared/handler";
import { genPoints } from "shared/map/point_gen";
import SpawnRemotes from "shared/spawn/remotes";
import SpawnCooldownManager from "shared/spawn/spawn_cooldown";

const requestSpawnRemote = SpawnRemotes.Server.Create("RequestSpawn");
const pointFolder = ReplicatedStorage.FindFirstChild("Points");
assert(t.instanceOf("Folder")(pointFolder), "Expected folder in the ReplicatedStorage named 'Points'");
const points = genPoints(pointFolder.GetChildren());
const random = new Random();

/**
 * Works in conjunction with the Spawn Gui to spawn the player
 */
export class SpawnHandler extends Handler {
    name = "Spawn";
    run() {
        Players.CharacterAutoLoads = false;
        Players.PlayerAdded.Connect(player => {
            player.CharacterAdded.Connect(character => {
                character.FindFirstChildWhichIsA("Humanoid")?.Died.Connect(() => {
                    Debris.AddItem(character, 4);
                });
            });
        });
        requestSpawnRemote.SetCallback((player, spawnArgs) => {
            const faction = getFactions().get(spawnArgs.faction);
            const point = points.find(p => p.name === spawnArgs.pointName);
            // realistically the client should never get these errors (it wouldn't fire in the first place), but just in case...
            if (!point)
                return [false, "Point does not exist!"];
            if (!point.canSpawn || !point.spawnPoints)
                return [false, `Cannot spawn at point ${point.name}!`];
            if (point.controllingFaction !== -1 && point.controllingFaction === faction?.groupId)
                return [false, `Spawn is controlled by enemy faction!`];
            if (faction && !faction.isInFaction(player))
                return [false, `Unable to spawn as faction ${faction.name}!`];
            if (!SpawnCooldownManager.canSpawn(player, point.name) && !point.safezone)
                return [false, `Spawn cooldown hasn't worn off yet! ${SpawnCooldownManager.getCooldownSecsRemaining(player, point.name)} seconds remaining.`]
            const spawnLocation = point.spawnPoints[random.NextInteger(0, point.spawnPoints.size() - 1)];
            const team = faction ? getTeams().get(faction?.groupId) : getTeams().get(-1);
            SpawnCooldownManager.logSpawn(player, point.name);
            player.Team = t.instanceIsA("Team")(team) ? team : undefined;
            new Promise<void>(resolve => resolve(player.LoadCharacter()));
            const character = player.CharacterAdded.Wait() as LuaTuple<[character: Character]>;
            if (faction && faction.uniformTop && faction.uniformBottom) {
                Avatar.changeShirt(character[0], faction.uniformTop);
                Avatar.changePants(character[0], faction.uniformBottom);
            }
            new Promise<void>(resolve => {
                if (!character[0].Parent)
                    character[0].AncestryChanged.Wait();
                RunService.Heartbeat.Wait();
                character[0].MoveTo(spawnLocation);
                resolve();
            });
            return [true, ""];
        });
    }
}