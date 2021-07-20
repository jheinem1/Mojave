import { StarterGui } from "@rbxts/services";
import { SpawnGui } from "./spawn_gui";
import { HUD } from "./hud";
import SpawnRemotes from "shared/spawn/remotes";
import { Handler } from "shared/handler";

const diedRemote = SpawnRemotes.Client.WaitFor("Died");

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
    // StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
    HUD.mount();
}
async function onDied() {
    try {
        HUD.unmount();
    } catch (error) { }
    wait(4);
    onLoad();
}

/**
 * Manages Roact Gui on the client
 */
export class GuiHandler extends Handler {
    name = "GUI";
    run() {
        diedRemote.then(remote => {
            remote.Connect(onDied);
            onLoad();
        })
    }
}