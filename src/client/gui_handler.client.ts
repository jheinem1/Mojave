import { Players, StarterGui } from "@rbxts/services";
import { SpawnGui } from "./spawn_gui";
import { HUD } from "./hud";

function onLoad() {
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
function onDied() {
    try {
        HUD.unmount();
    } catch (error) { }
    wait(4);
    onLoad();
}

onLoad();
Players.LocalPlayer.Character?.FindFirstChildWhichIsA("Humanoid")?.Died.Connect(onDied);
Players.LocalPlayer.CharacterAdded.Connect(character => character.FindFirstChildWhichIsA("Humanoid")?.Died.Connect(onDied));