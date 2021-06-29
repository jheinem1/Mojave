import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";

export abstract class Screen {
    position: number;
    finished = new ObjectEvent<[]>();
    deselected = new ObjectEvent<[]>();
    selected = new ObjectEvent<[]>();
    constructor(position: number) {
        this.position = position;
    }
    abstract getScreenComponent(): Roact.Element;
    abstract getButtonComponent(): Roact.Element;
}