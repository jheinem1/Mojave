import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, ReplicatedStorage, RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientRegions } from "shared/regions";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Client.Get("InSafezone");
const validSafezoneChildren = t.array(t.instanceIsA("BasePart"));
const safezoneFolder = Workspace.FindFirstChild("Safezones") ?? ReplicatedStorage.FindFirstChild("Safezones");
assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage");
const safezoneParts = safezoneFolder.GetChildren();
assert(validSafezoneChildren(safezoneParts), "Expected children of 'Safezones' folder to be BaseParts");
const safezoneRegions = new ClientRegions(safezoneParts);
let shielded = false;

inSafezone.Connect((isInSafezone) => {
    if (isInSafezone) {
        shielded = true;
    } else {
        shielded = false;
        if (safezoneRegions.isInRegion()) {
            wait(0.5);
            shielded = true;
            inSafezone.SendToServer(true);
        }
    }
});

safezoneRegions.enteredRegion.Connect(() => {
    if (!shielded) {
        shielded = true;
        wait();
        inSafezone.SendToServer(true);
    }
})

game.BindToClose(() => safezoneRegions.kill());