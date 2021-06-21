import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import Remotes from "shared/remotes";

const inSafezoneRemote = Remotes.Server.Create("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezones = safezoneParts.map((safezonePart) => RotatedRegion3.FromPart(safezonePart));
const rootParts = new Map<Model, Part>();
const shielded = new Map<Model, ForceField>();

safezoneFolder.Destroy();

Players.PlayerAdded.Connect((player) => {
    player.CharacterAdded.Connect((character) => {
        const rootPart = character.FindFirstChild("HumanoidRootPart");
        if (t.instanceOf("Part")(rootPart))
            rootParts.set(character, rootPart);
    });
});

RunService.Heartbeat.Connect(() => {
    const inSafezone = new Array<Model>();
    for (const [character, rootPart] of rootParts)
        if (safezones.some((safezone) => safezone.CastPart(rootPart)))
            inSafezone.push(character);
        else if (shielded.get(character)) {
            shielded.get(character)?.Destroy()
            shielded.delete(character);
        }
    for (const character of inSafezone) {
        if (!shielded.get(character)) {
            const forceField = new Instance("ForceField");
            forceField.Visible = false;
            forceField.Name = "Safezone";
            forceField.Parent = character;
            shielded.set(character, forceField);
            const player = Players.GetPlayerFromCharacter(character);
            if (player)
                inSafezoneRemote.SendToPlayer(player, true);
        }
    }
});