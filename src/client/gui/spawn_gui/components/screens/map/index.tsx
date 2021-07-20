import Roact from "@rbxts/roact";
import { Workspace } from "@rbxts/services";
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
    imageref = Roact.createRef<ImageLabel>();
    posBinding = Roact.createBinding(new UDim2());
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
    didMount() {
        const ref = this.imageref.getValue();
        const camera = Workspace.CurrentCamera;
        if (ref && camera) {
            this.posBinding[1](UDim2.fromOffset((camera.ViewportSize.X - ref.AbsoluteSize.X) / 2, 0));
            let connection: RBXScriptConnection;
            connection = camera.GetPropertyChangedSignal("ViewportSize").Connect(() => {
                if (ref)
                    this.posBinding[1](UDim2.fromOffset((camera.ViewportSize.X - ref.AbsoluteSize.X) / 2, 0));
                else
                    connection.Disconnect();
            });
        }
    }
    render() {
        return <frame
            Key="Map"
            BackgroundColor3={Color3.fromRGB(46, 46, 46)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
            // SizeConstraint={Enum.SizeConstraint.RelativeYY}
            Event={{
                InputEnded: (_frame, input) => {
                    if (input.UserInputType === Enum.UserInputType.MouseButton1)
                        this.onClick();
                }
            }}
        >
            <imagelabel
                Key="MapFrame"
                BackgroundTransparency={0}
                Position={this.posBinding[0]}
                Size={new UDim2(1, 0, 1, 0)}
                BorderSizePixel={3}
                Image={"rbxassetid://7124206064"}
                // ScaleType={Enum.ScaleType.Fit}
                SizeConstraint={Enum.SizeConstraint.RelativeYY}
                BackgroundColor3={Color3.fromRGB(143, 130, 31)}
                BorderColor3={Color3.fromRGB(0, 0, 0)}
                BorderMode={Enum.BorderMode.Inset}
                Ref={this.imageref}
            >
                <frame
                    BackgroundTransparency={1}
                    Position={UDim2.fromScale(0.1, 0.1)}
                    Size={UDim2.fromScale(0.8, 0.8)}
                >
                    {this.mapPoints}
                </frame>
            </imagelabel>
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