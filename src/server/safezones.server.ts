import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, ReplicatedStorage, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientRegions } from "shared/regions";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Server.Create("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones") ?? ReplicatedStorage.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezones = safezoneParts.map((safezonePart) => RotatedRegion3.FromPart(safezonePart));
const shielded = new WeakMap<Model, ForceField>();

safezoneFolder.Parent = ReplicatedStorage;

function isInSafezone(character: Model) {
    const rootPart = character.FindFirstChild("HumanoidRootPart");
    if (t.instanceIsA("BasePart")(rootPart) && safezones.some((safezone) => safezone.CastPart(rootPart)))
        return true;
    return false;
}

inSafezone.Connect((player, _) => {
    const character = player.Character;
    if (character && isInSafezone(character)) {
        const forceField = new Instance("ForceField");
        forceField.Visible = false;
        forceField.Name = "Safezone";
        forceField.Parent = character;
        shielded.set(character, forceField);
        inSafezone.SendToPlayer(player, true);
        const clientRegions = new ClientRegions(safezones, player);
        clientRegions.leftRegion.Connect(() => {
            forceField.Destroy();
            inSafezone.SendToPlayer(player, false);
            clientRegions.kill();
        });
    } else {
        inSafezone.SendToPlayer(player, false);
    }
});

Players.PlayerAdded.Connect(player => {
    player.CharacterAdded.Connect(character => {
        wait();
        if (isInSafezone(character)) {
            const forceField = new Instance("ForceField");
            forceField.Visible = false;
            forceField.Name = "Safezone";
            forceField.Parent = character;
            shielded.set(character, forceField);
            inSafezone.SendToPlayer(player, true);
            const clientRegions = new ClientRegions(safezones, player);
            clientRegions.leftRegion.Connect(() => {
                forceField.Destroy();
                inSafezone.SendToPlayer(player, false);
                clientRegions.kill();
            });
        }
    });
});


// RunService.Heartbeat.Connect(() => {
//     Players.GetPlayers().forEach((player) => {
//         const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
//         const existingForceField = player.Character?.FindFirstChild("Safezone");
//         const isInSafezone = t.instanceOf("Part")(rootPart) ? safezones.some((savezone) => savezone.CastPart(rootPart)) : false;
//         if (!existingForceField && rootPart && isInSafezone) {
//             const forceField = new Instance("ForceField");
//             forceField.Visible = false;
//             forceField.Name = "Safezone";
//             forceField.Parent = player.Character;
//             inSafezone.SendToPlayer(player, true);
//         } else if (existingForceField && rootPart && !isInSafezone) {
//             existingForceField.Destroy();
//             inSafezone.SendToPlayer(player, false);
//         }
//     });
// });