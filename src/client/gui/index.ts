import { Players, StarterGui } from "@rbxts/services";
import { SpawnGui } from "./spawn_gui";
import { HUD } from "./hud";
import { Handler } from "shared/handler";


async function onLoad() {
    try {
        StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
        SpawnGui.mount();
        SpawnGui.finished.Wait();
        SpawnGui.unmount();
    } catch (error) {
        warn(`Unable to load SpawnGui! Error: ${error}`);
    }
    StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
}
async function onDied() {
    onLoad();
}

/**
 * Manages Roact Gui on the client
 */
export class GuiHandler extends Handler {
    name = "GUI";
    run() {
        Players.LocalPlayer.CharacterAdded.Connect(character => character.AncestryChanged.Connect(() => {
            if (!character.Parent)
                onDied()
        }));
        onLoad();
        HUD.mount();
    }
}