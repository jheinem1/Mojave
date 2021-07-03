import { Players, ReplicatedStorage, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { BasePartRegion, RegionUnion } from "shared/region";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Server.Create("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones") ?? ReplicatedStorage.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezoneRegions = new RegionUnion(safezoneParts.map((safezonePart) => new BasePartRegion(safezonePart)));
const shielded = new WeakMap<Model, ForceField>();

safezoneFolder.Parent = ReplicatedStorage;

function safezoneCheck(player: Player, character: Model | undefined = player.Character) {
    if (character?.PrimaryPart && safezoneRegions.isInRegion(character.PrimaryPart)) {
        const forceField = new Instance("ForceField");
        forceField.Visible = false;
        forceField.Name = "Safezone";
        forceField.Parent = character;
        shielded.set(character, forceField);
        inSafezone.SendToPlayer(player, true);
        safezoneRegions.enteredRegion(character.PrimaryPart).then(() => {
            forceField.Destroy();
            inSafezone.SendToPlayer(player, false);
        });
    } else {
        inSafezone.SendToPlayer(player, false);
    }
}

inSafezone.Connect((player, _) => safezoneCheck(player));

Players.PlayerAdded.Connect(player => {
    player.CharacterAdded.Connect(character => {
        RunService.Heartbeat.Wait();
        safezoneCheck(player, character);
    });
});