import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { Screen } from "../screen";


interface MapProps {
    finished: ObjectEvent<[]>;
}

class MapComponent extends Roact.Component<MapProps, {}> {
    render() {
        return <frame
            Key="Map"
            BackgroundColor3={Color3.fromRGB(126, 111, 42)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            <frame
                Key="MapImage"
                BackgroundTransparency={1}
                // Image="rbxassetid://7010013959"
                Position={new UDim2(0.5, -960, 0, 0)}
                // ScaleType={Enum.ScaleType.Fit}
                Size={new UDim2(0, 1920, 1, 0)}
            // SliceScale={0}
            >
            </frame>
        </frame>
    }
}

export class MapScreen extends Screen {
    name = "Spawn";
    getScreenComponent(): Roact.Element {
        return <MapComponent
            finished={this.finished}
        />;
    }
}