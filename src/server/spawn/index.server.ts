import { ReplicatedStorage, Teams } from "@rbxts/services";
import { t } from "@rbxts/t";
import { getFactions } from "server/factions";
import { genPoints } from "shared/map/point_gen";
import SpawnRemotes from "shared/spawn/remotes";
import SpawnCooldownManager from "shared/spawn/spawn_cooldown";

const remote = SpawnRemotes.Server.Create("RequestSpawn");
const pointFolder = ReplicatedStorage.FindFirstChild("Points");
assert(t.instanceOf("Folder")(pointFolder), "Expected folder in the ReplicatedStorage named 'Points'");
const points = genPoints(pointFolder.GetChildren());
const random = new Random();

remote.SetCallback((client, spawnArgs) => {
    const faction = getFactions().get(spawnArgs.faction);
    const point = points.find(p => p.name === spawnArgs.pointName);
    // realistically the client should never get these errors (it wouldn't fire in the first place), but just in case...
    if (!point)
        return [false, "Point does not exist!"];
    if (!point.canSpawn || !point.spawnPoints)
        return [false, `Cannot spawn at point ${point.name}!`];
    if (point.controllingFaction !== -1 && point.controllingFaction === faction?.groupId)
        return [false, `Spawn is controlled by enemy faction!`];
    if (faction?.isInFaction(client))
        return [false, `Unable to spawn as faction ${faction.name}!`];
    if (SpawnCooldownManager.canSpawn(client, point.name))
        return [false, `Spawn cooldown hasn't worn off yet! ${SpawnCooldownManager.getCooldownSecsRemaining(client, point.name)} seconds remaining.`]
    const spawnLocation = point.spawnPoints[random.NextInteger(0, point.spawnPoints.size())];
    const team = Teams.FindFirstChild(faction?.name ?? "Wastelanders")
    SpawnCooldownManager.logSpawn(client, point.name);
    client.Team = t.instanceIsA("Team")(team) ? team : undefined;
    client.LoadCharacter();
    const character = client.CharacterAdded.Wait();
    character[0].SetPrimaryPartCFrame(new CFrame(spawnLocation));
    return [true];
});