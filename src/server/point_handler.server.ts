import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";

const location = Workspace.FindFirstChild("Points") ?? ReplicatedStorage.FindFirstChild("Points");
assert(t.instanceOf("Folder")(location), "Expected folder in the Workspace or ReplicatedStorage named 'Points'");
location.Parent = ReplicatedStorage;