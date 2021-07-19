import Roact from "@rbxts/roact";
import { RunService, UserInputService } from "@rbxts/services";
import { getFactions } from "client/factions";
import { Point } from "shared/map/point";
import { SelectedPoint } from ".";
import { TooltipBindings as TooltipBindings } from "./tooltip";

interface MapPointComponentProps {
    point: Point;
    size: Vector2;
    tooltipBindings: TooltipBindings;
    selectedPoint: SelectedPoint;
}

export class MapPointComponent extends Roact.Component<MapPointComponentProps> {
    position: UDim2;
    buttonRef = Roact.createRef<TextButton>();
    controllingFaction: Roact.Binding<Color3>;
    setControllingFaction: (color: Color3) => void;
    factions = getFactions();
    constructor(props: MapPointComponentProps) {
        super(props);
        const relPosition = new Vector2(props.point.position.X / props.size.X, props.point.position.Y / props.size.Y);
        this.position = UDim2.fromScale(relPosition.X, relPosition.Y);
        [this.controllingFaction, this.setControllingFaction] = Roact.createBinding(Color3.fromRGB(79, 79, 79));
        this.factions.then(factions => {
            const existingFaction = factions.find(faction => props.point.controllingFaction === faction.groupId);
            if (existingFaction)
                this.setControllingFaction(existingFaction.color.Color);
            props.point.capturePointStatus.Changed.Connect(id =>
                this.setControllingFaction(factions.find(faction => id === faction.groupId)?.color.Color ?? Color3.fromRGB(79, 79, 79))
            );
        })
    }
    inBounds(position: Vector2, button: GuiObject) {
        position = position.add(new Vector2(0, -36));
        if (button) {
            const buttonPos = button.AbsolutePosition;
            const buttonEndPos = buttonPos.add(button.AbsoluteSize);
            if (position.X >= buttonPos.X && position.Y >= buttonPos.Y
                && position.X <= buttonEndPos.X && position.Y <= buttonEndPos.Y)
                return true;
        }
        return false
    }
    onHover() {
        const tooltipBindings = this.props.tooltipBindings;
        const button = this.buttonRef.getValue();
        if (tooltipBindings && button) {
            const point = this.props.point;
            let controllingFaction = "Loading...";
            this.factions.then(factions => {
                controllingFaction = factions.find(faction => this.props.point.controllingFaction === faction.groupId)?.shortName ?? "UNKNOWN";
                tooltipBindings.setTooltipText(`NAME: ${point.name}\nSAFEZONE: ${point.safezone ? "YES" : "NO"}` +
                    `\nCAN SPAWN: ${point.canSpawn ? "YES" : "NO"}` +
                    `\nCONTROLLING FACTION: ${controllingFaction}`);
            });
            let mousePos = UserInputService.GetMouseLocation();
            RunService.BindToRenderStep("MapToolTip", 1, () => {
                const newMousePos = UserInputService.GetMouseLocation();
                if (newMousePos !== mousePos && !tooltipBindings.tooltipSelected.getValue()) {
                    mousePos = newMousePos;
                    tooltipBindings.setTooltipPosition(mousePos);
                    tooltipBindings.setTooltipText(`NAME: ${point.name}\nSAFEZONE: ${point.safezone ? "YES" : "NO"}` +
                        `\nCAN SPAWN: ${point.canSpawn ? "YES" : "NO"}` +
                        `\nCONTROLLING FACTION: ${controllingFaction}`);
                }
                if (!this.inBounds(newMousePos, button)) {
                    RunService.UnbindFromRenderStep("MapToolTip");
                    if (!tooltipBindings.tooltipSelected.getValue())
                        tooltipBindings.setTooltip(false);
                }
            });
            wait();
            tooltipBindings.setTooltip(true);
        }
    }
    onClick() {
        const tooltipBindings = this.props.tooltipBindings;
        if (!tooltipBindings.tooltipSelected.getValue() && this.props.point.canSpawn && tooltipBindings) {
            this.props.selectedPoint[1](this.props.point)
            const mousePos = UserInputService.GetMouseLocation();
            tooltipBindings.setTooltipPosition(mousePos);
            if (!tooltipBindings.tooltip.getValue()) {
                tooltipBindings.setTooltip(true);
                tooltipBindings.setTooltipText(``);
            }
            wait();
            tooltipBindings.setTooltipSelected(true);
        } else if (tooltipBindings.tooltipSelected.getValue())
            tooltipBindings.setTooltipSelected(false);
    }
    render() {
        const borderColor = this.props.point.safezone ? Color3.fromRGB(92, 168, 255) : Color3.fromRGB(255, 226, 86);
        return <textbutton
            Key="Destination"
            BackgroundColor3={this.controllingFaction}
            BorderColor3={borderColor}
            BorderSizePixel={5}
            BorderMode={Enum.BorderMode.Inset}
            Font={Enum.Font.SourceSans}
            Position={this.position}
            Size={new UDim2(0, 30, 0, 30)}
            Text={""}
            TextColor3={Color3.fromRGB(0, 0, 0)}
            TextSize={14}
            AutoButtonColor={false}
            Event={{
                MouseEnter: () => this.onHover(),
                MouseButton1Click: () => this.onClick()
            }}
            Ref={this.buttonRef}
        >
            <textlabel
                Key="Title"
                Position={new UDim2(0.5, -20, -1, 0)}
                Size={new UDim2(0, 40, 1, 0)}
                BackgroundTransparency={1}
                TextSize={15}
                TextColor3={Color3.fromRGB(0, 0, 0)}
                TextStrokeColor3={borderColor}
                TextStrokeTransparency={0}
                TextYAlignment={Enum.TextYAlignment.Top}
                TextXAlignment={Enum.TextXAlignment.Center}
                Font={Enum.Font.SourceSansBold}
                Text={this.props.point.name}
            />
        </textbutton>
    }
}