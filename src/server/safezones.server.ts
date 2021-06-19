import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";

const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezones = safezoneParts.map((safezonePart) => RotatedRegion3.FromPart(safezonePart));

safezoneFolder.Destroy();

RunService.Heartbeat.Connect(() => {
    Players.GetPlayers().forEach((player) => {
        const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
        const forceField = player.Character?.FindFirstChildWhichIsA("ForceField");
        if (rootPart && !forceField && t.instanceOf("Part")(rootPart) && safezones.some((savezone) => savezone.CastPart(rootPart)))
            new Instance("ForceField", player.Character).Visible = false;
        else if (forceField && rootPart && t.instanceOf("Part")(rootPart) && !safezones.some((savezone) => savezone.CastPart(rootPart)))
            forceField.Destroy();
    });
});