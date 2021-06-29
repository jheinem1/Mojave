import Roact, { Element } from "@rbxts/roact";
import { MapScreen } from "./screens/map";
import { Screen } from "./screens/screen";
import { TeamsScreen } from "./screens/teams";

interface ProgressState {
    currentScreen: number;
}

export class ProgressComponent extends Roact.Component<{}, ProgressState> {
    screens: Screen[] = [
        new TeamsScreen(0),
        new MapScreen(1)
    ]
    defaultProps = {
        currentScreen: 0
    }
    onSelect(screen: Screen) {
        this.setState({ currentScreen: screen.position });
    }
    render() {
        const items = [<uilistlayout
            FillDirection={Enum.FillDirection.Horizontal}
            HorizontalAlignment={Enum.HorizontalAlignment.Center}
            Padding={new UDim(0.1, 0)}
            SortOrder={Enum.SortOrder.LayoutOrder}
        />]
        this.screens.forEach(screen => items.push(screen.getButtonComponent(() => this.onSelect(screen))));
        return <frame>
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