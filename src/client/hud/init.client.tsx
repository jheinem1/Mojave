import Roact from "@rbxts/roact";
import { Players, StarterGui } from "@rbxts/services";
import { HudComponent } from "./hud_component";

StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
Roact.mount(<HudComponent />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));