import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { SpawnGuiComponent } from "./components/spawn_gui";

export class SpawnGui {
    static spawnGuiListener: Roact.Tree | undefined;
    static finished = new ObjectEvent<[]>();
    static mount() {
        const screenBinding = Roact.createBinding(0);
        SpawnGui.spawnGuiListener = Roact.mount(<SpawnGuiComponent currentScreen={screenBinding} finished={this.finished} />, Players.LocalPlayer.FindFirstChildOfClass("PlayerGui"));
    }
    static unmount() {
        if (SpawnGui.spawnGuiListener)
            Roact.unmount(SpawnGui.spawnGuiListener);
    }
}