import { StarterGui } from "@rbxts/services";
import { HUD } from "./hud";
import { SpawnGui } from "./spawn_gui";

StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
SpawnGui.mount();
// HUD.mount();