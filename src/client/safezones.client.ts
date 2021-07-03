import { Players, ReplicatedStorage, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { BasePartRegion, RegionUnion } from "shared/region";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Client.Get("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones") ?? ReplicatedStorage.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezoneRegions = new RegionUnion(safezoneParts.map((safezonePart) => new BasePartRegion(safezonePart)));
let shielded = false;

function enteredRegion(part: BasePart) {
    if (!shielded) {
        shielded = true;
        wait();
        inSafezone.SendToServer(true);
    }
    safezoneRegions.enteredRegion(part).then(() => enteredRegion(part));
}

function onCharacter(character: Model) {
    const part = character.PrimaryPart
    if (part) {
        safezoneRegions.enteredRegion(part).then(() => enteredRegion(part));
    }
}

inSafezone.Connect((isInSafezone) => {
    if (isInSafezone) {
        shielded = true;
    } else {
        shielded = false;
        const root = Players.LocalPlayer.Character?.PrimaryPart;
        if (root && safezoneRegions.isInRegion(root)) {
            wait(0.5);
            shielded = true;
            inSafezone.SendToServer(true);
        }
    }
});

Players.LocalPlayer.CharacterAdded.Connect(onCharacter);
if (Players.LocalPlayer.Character)
    onCharacter(Players.LocalPlayer.Character);