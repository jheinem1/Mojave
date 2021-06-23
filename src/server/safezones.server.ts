import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Server.Create("InSafezone");
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
        const existingForceField = player.Character?.FindFirstChild("Safezone");
        const isInSafezone = t.instanceOf("Part")(rootPart) ? safezones.some((savezone) => savezone.CastPart(rootPart)) : false;
        if (!existingForceField && rootPart && isInSafezone) {
            const forceField = new Instance("ForceField");
            forceField.Visible = false;
            forceField.Name = "Safezone";
            forceField.Parent = player.Character;
            inSafezone.SendToPlayer(player, true);
        } else if (existingForceField && rootPart && !isInSafezone) {
            existingForceField.Destroy();
            inSafezone.SendToPlayer(player, false);
        }
    });
});