import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import gameMap from "client/client_points_handler";
import { Screen } from "../screen";
import { MapPointComponent } from "./map_point";


interface MapProps {
    finished: ObjectEvent<[]>;
}

class MapComponent extends Roact.Component<MapProps> {
    mapPoints: Roact.Element[];
    constructor(props: MapProps) {
        super(props);
        this.mapPoints = gameMap.points.map(point => <MapPointComponent
            point={point}
            size={gameMap.size}
        />);
    }
    render() {
        return <frame
            Key="Map"
            BackgroundColor3={Color3.fromRGB(126, 111, 42)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            {/* <frame
                Key="MapImage"
                BackgroundTransparency={0}
                Position={new UDim2(0.5, -960, 0, 0)}
                Size={new UDim2(0, 1920, 1, 0)}
                BackgroundColor3={new Color3(1, 1, 1)}
                BorderSizePixel={0}
            > */}
            {this.mapPoints}
            {/* </frame> */}
        </frame>
    }
}

export class MapScreen extends Screen {
    name = "Spawn";
    constructor(public position: number, public currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>, public finished: ObjectEvent<[]>) {
        super(position, currentScreen);
    }
    getScreenComponent(): Roact.Element {
        return <MapComponent
            finished={this.finished}
        />;
    }
}