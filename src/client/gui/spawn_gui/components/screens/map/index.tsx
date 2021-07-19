import Roact from "@rbxts/roact";
import gameMap from "client/points/points";
import { Point } from "shared/map/point";
import { Screen } from "../screen";
import { MapPointComponent } from "./map_point";
import { TooltipBindings, TooltipComponent } from "./tooltip";


interface MapProps {
    finished: (point: Point) => void;
}

export type SelectedPoint = LuaTuple<[Roact.Binding<Point | undefined>, (selectedFaction: Point | undefined) => void]>;

class MapComponent extends Roact.Component<MapProps> {
    mapPoints: Roact.Element[];
    tooltipBindings: TooltipBindings;
    selectedPoint: SelectedPoint;
    constructor(props: MapProps) {
        super(props);
        const [tooltip, setTooltip] = Roact.createBinding(false);
        const [tooltipText, setTooltipText] = Roact.createBinding("");
        const [tooltipPosition, setTooltipPosition] = Roact.createBinding(new Vector2);
        const [tooltipSelected, setTooltipSelected] = Roact.createBinding(false);
        this.tooltipBindings = {
            tooltip: tooltip,
            setTooltip: setTooltip,
            tooltipText: tooltipText,
            setTooltipText: setTooltipText,
            tooltipPosition: tooltipPosition,
            setTooltipPosition: setTooltipPosition,
            tooltipSelected: tooltipSelected,
            setTooltipSelected: setTooltipSelected
        };
        this.selectedPoint = Roact.createBinding(undefined) as SelectedPoint;
        this.mapPoints = gameMap.points.map((point: Point) => <MapPointComponent
            point={point}
            size={gameMap.size}
            tooltipBindings={this.tooltipBindings}
            selectedPoint={this.selectedPoint}
        />);
    }
    onClick() {
        this.tooltipBindings.setTooltip(false);
        this.tooltipBindings.setTooltipSelected(false);
    }
    render() {
        return <frame
            Key="Map"
            BackgroundColor3={Color3.fromRGB(46, 46, 46)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
            Event={{
                InputEnded: (_frame, input) => {
                    if (input.UserInputType === Enum.UserInputType.MouseButton1)
                        this.onClick();
                }
            }}
        >
            <frame
                Key="MapFrame"
                BackgroundTransparency={1}
                Position={new UDim2(0.1, 0, 0.1, 0)}
                Size={new UDim2(0.8, -30, 0.8, -30)}
                BorderSizePixel={0}
            >
                {this.mapPoints}
            </frame>
            <TooltipComponent
                tooltipBindings={this.tooltipBindings}
                event={{
                    onSpawn: () => {
                        const point = this.selectedPoint[0].getValue();
                        if (point)
                            this.props.finished(point);
                    }
                }}
            />
        </frame>
    }
}

export class MapScreen extends Screen {
    name = "Spawn";
    constructor(public position: number, public currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>, public finished: (point: Point) => void) {
        super(position, currentScreen);
    }
    getScreenComponent(): Roact.Element {
        return <MapComponent
            finished={this.finished}
        />;
    }
}