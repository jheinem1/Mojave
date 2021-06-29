import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { SpawnGuiComponent } from "./components/spawn_gui";

export class SpawnGui {
    static spawnGuiListener: Roact.Tree | undefined;
    static mount() {
        SpawnGui.spawnGuiListener = Roact.mount(<SpawnGuiComponent />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));
    }
    static unmount() {
        if (SpawnGui.spawnGuiListener)
            Roact.unmount(SpawnGui.spawnGuiListener);
    }
}