import Roact from "@rbxts/roact";
import { Players, StarterGui } from "@rbxts/services";
import { HudComponent } from "./components/hud_component";

export class HUD {
    static hudListener: Roact.Tree | undefined;
    static mount() {
        HUD.hudListener = Roact.mount(<HudComponent />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));
    }
    static unmount() {
        if (HUD.hudListener)
            Roact.unmount(HUD.hudListener);
    }
}