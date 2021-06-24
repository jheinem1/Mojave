import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { HudComponent } from "./hud_component";

Roact.mount(<HudComponent />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));