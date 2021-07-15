import { StarterGui } from "@rbxts/services";
import { SpawnGui } from "./spawn_gui";
import { HUD } from "./hud";

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