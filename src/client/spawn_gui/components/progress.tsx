import ObjectEvent from "@rbxts/object-event";
import Roact, { Element } from "@rbxts/roact";
import { MapScreen } from "./screens/map";
import { Screen } from "./screens/screen";
import { TeamsScreen } from "./screens/teams";

interface ProgressState {
    currentScreen: number;
}

interface ProgressProps { }

export class ProgressComponent extends Roact.Component<ProgressProps, ProgressState> {
    screens: Screen[] = [
        new TeamsScreen(0),
        new MapScreen(1)
    ]
    constructor(props: ProgressProps) {
        super(props);
        this.setState({ currentScreen: this.screens[0].position });
        this.screens[this.state.currentScreen].selected.Fire();
        this.screens.forEach(screen => screen.selected.Connect(() => this.onSelect(screen)));
    }
    onSelect(screen: Screen) {
        this.setState({ currentScreen: screen.position });
        this.screens.forEach(otherScreen => {
            if (screen !== otherScreen)
                otherScreen.deselected.Fire();
        });
    }
    render() {
        const items = [<uilistlayout
            FillDirection={Enum.FillDirection.Horizontal}
            HorizontalAlignment={Enum.HorizontalAlignment.Center}
            Padding={new UDim(0.1, 0)}
            SortOrder={Enum.SortOrder.LayoutOrder}
        />]
        this.screens.forEach(screen => items.push(screen.getButtonComponent()));
        return <frame BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            {Roact.createElement("Frame", {
                Name: "List",
                BackgroundTransparency: 1,
                Position: new UDim2(0.3, 70, 0, 0),
                Size: new UDim2(0.7, -70, 0, 36)
            }, items)}
            {this.screens[this.state.currentScreen].getScreenComponent()}
        </frame>;
    }
}