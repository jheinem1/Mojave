import { ReplicatedStorage } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Faction, getFactions } from "server/factions/faction";
import { Handler } from "shared/handler";

const location = ReplicatedStorage.FindFirstChild("FamilyList");

function generateFactionFolder(faction: Faction) {
    const folder = new Instance("Folder");
    folder.Name = faction.name;

    const idValue = new Instance("NumberValue");
    idValue.Name = "GroupID";
    idValue.Value = faction.groupId;
    idValue.Parent = folder;

    const decal = new Instance("Decal");
    decal.Name = "Flag";
    decal.Texture = faction.emblem;
    decal.Parent = folder;

    return folder;
}

function generate() {
    location?.ClearAllChildren();
    getFactions().forEach(faction => generateFactionFolder(faction).Parent = location);
}

/**
 * Generates factions for the (terrible) capture points script
 */
export class FactionGeneratorHandler extends Handler {
    name = "Faction Generator";
    run() {
        assert(t.instanceOf("Folder")(location), "Expected folder in ReplicatedStorage named 'FamilyList'");
        // const bindable = script.Parent?.FindFirstChild("onjoin")?.FindFirstChild("reloadteams")
        // if (t.instanceIsA("BindableEvent")(bindable))
        //     bindable.Event.Connect(generate);
        generate();
    }
}