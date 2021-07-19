import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { ProgressItemComponent } from "./progress_item";

export abstract class Screen {
    startSelected: boolean;
    deselected = new ObjectEvent<[]>();
    selected = new ObjectEvent<[]>();
    abstract name: string;
    constructor(public position: number, public currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>) {
        this.startSelected = position === 0;
    }
    getButtonComponent(): Roact.Element {
        return <ProgressItemComponent
            name={this.name}
            position={this.position}
            startSelected={this.startSelected}
            deselectEvent={this.deselected}
            selected={this.currentScreen[0]}
            updateSelection={this.currentScreen[1]}
        />;
    }
    abstract getScreenComponent(): Roact.Element;
}