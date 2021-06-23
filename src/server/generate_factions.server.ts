import { ReplicatedStorage } from "@rbxts/services";
import { t } from "@rbxts/t";
import Allies from "shared/allies";

const location = ReplicatedStorage.FindFirstChild("FamilyList");
assert(t.instanceOf("Folder")(location), "Expected folder in ReplicatedStorage named 'FamilyList'");

function generateFactionFolder(group: GroupInfo) {
    const folder = new Instance("Folder");
    folder.Name = group.Name;

    const idValue = new Instance("NumberValue");
    idValue.Name = "GroupID";
    idValue.Value = group.Id;
    idValue.Parent = folder;

    const decal = new Instance("Decal");
    decal.Name = "Flag";
    decal.Texture = group.EmblemUrl;
    decal.Parent = folder;

    return folder;
}

function generate() {
    location?.ClearAllChildren();
    for (const group of Allies.allies)
        generateFactionFolder(group).Parent = location;
}

const bindable = script.Parent?.FindFirstChild("onjoin")?.FindFirstChild("reloadteams")
if (t.instanceIsA("BindableEvent")(bindable))
    bindable.Event.Connect(generate);

generate();