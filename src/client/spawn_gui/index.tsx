import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { SpawnGuiComponent } from "./components/spawn_gui";

export class SpawnGui {
    static spawnGuiListener: Roact.Tree | undefined;
    static mount() {
        const screenBinding = Roact.createBinding(0);
        SpawnGui.spawnGuiListener = Roact.mount(<SpawnGuiComponent currentScreen={screenBinding} />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));
    }
    static unmount() {
        if (SpawnGui.spawnGuiListener)
            Roact.unmount(SpawnGui.spawnGuiListener);
    }
}