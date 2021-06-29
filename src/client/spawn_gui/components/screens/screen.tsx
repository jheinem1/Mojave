import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";

export abstract class Screen {
    position: number;
    finished = new ObjectEvent();
    constructor(position: number) {
        this.position = position;
    }
    abstract getScreenComponent(onSpawn?: () => void): Roact.Element;
    abstract getButtonComponent(onSelect: () => void): Roact.Element;
}