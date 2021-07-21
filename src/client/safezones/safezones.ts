import { Players, ReplicatedStorage, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Handler } from "shared/handler";
import { BasePartRegion, RegionUnion } from "shared/region";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Client.Get("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones") ?? ReplicatedStorage.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezoneRegions = new RegionUnion(safezoneParts.map((safezonePart) => BasePartRegion.fromPart(safezonePart)));
let shielded = false;

function enteredRegion(part: BasePart) {
    if (!shielded) {
        shielded = true;
        wait();
        inSafezone.SendToServer(true);
    }
}

function onCharacter(character: Model) {
    const part = character.WaitForChild("HumanoidRootPart");
    if (t.instanceIsA("Part")(part)) {
        const promise = safezoneRegions.enteredRegion(part);
        promise.then(() => enteredRegion(part));
        Players.LocalPlayer.CharacterRemoving.Connect(() => promise.cancel());
    }
}

/**
 * Manages safezones on the client
 */
export class SafezonesHandler extends Handler {
    name = "Safezones";
    run() {
        inSafezone.Connect((isInSafezone) => {
            if (isInSafezone)
                shielded = true;
            else {
                shielded = false;
                const root = Players.LocalPlayer.Character?.WaitForChild("HumanoidRootPart", 5);
                if (t.instanceIsA("Part")(root) && safezoneRegions.isInRegion(root.Position)) {
                    wait(0.5);
                    shielded = true;
                    inSafezone.SendToServer(true);
                } else if (t.instanceIsA("Part")(root)) {
                    const promise = safezoneRegions.enteredRegion(root);
                    promise.then(() => enteredRegion(root));
                    Players.LocalPlayer.CharacterRemoving.Connect(() => promise.cancel());
                }
            }
        });

        if (Players.LocalPlayer.Character)
            onCharacter(Players.LocalPlayer.Character);
        Players.LocalPlayer.CharacterAdded.Connect(onCharacter);
    }
}