import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { ProgressItemComponent } from "./progress_item";

export abstract class Screen {
    startSelected: boolean;
    finished = new ObjectEvent<[]>();
    deselected = new ObjectEvent<[]>();
    selected = new ObjectEvent<[]>();
    abstract name: string;
    constructor(public position: number, public currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>) {
        this.startSelected = position === 0;
    }
    getButtonComponent(): Roact.Element {
        return <ProgressItemComponent
            Name={this.name}
            Position={this.position}
            StartSelected={this.startSelected}
            DeselectEvent={this.deselected}
            SelectEvent={this.selected}
            Event={{
                Clicked: () => this.selected.Fire()
            }}
        />;
    }
    abstract getScreenComponent(): Roact.Element;
}