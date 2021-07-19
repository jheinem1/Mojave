import { Players, StarterGui } from "@rbxts/services";
import { SpawnGui } from "./spawn_gui";
import { HUD } from "./hud";
import SpawnRemotes from "shared/spawn/remotes";

const diedRemote = SpawnRemotes.Client.Get("Died");

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
    StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
    HUD.mount();
}
async function onDied() {
    try {
        HUD.unmount();
    } catch (error) { }
    wait(4);
    onLoad();
}

diedRemote.Connect(onDied);
onLoad();