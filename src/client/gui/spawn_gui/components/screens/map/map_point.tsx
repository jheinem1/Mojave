import Roact from "@rbxts/roact";
import { Players, RunService, UserInputService } from "@rbxts/services";
import { getFactions } from "client/factions";
import { generateShortName } from "shared/factions/utility_functions";
import { Point } from "shared/map/point";
import SpawnCooldownManager from "shared/spawn/spawn_cooldown";
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
            let tooltipText = "";
            this.factions.then(factions => {
                controllingFaction = factions.find(faction => this.props.point.controllingFaction === faction.groupId)?.name ?? "UNKNOWN";
            });
            let mousePos = UserInputService.GetMouseLocation();
            RunService.BindToRenderStep("MapToolTip", 1, () => {
                const newMousePos = UserInputService.GetMouseLocation();
                const newTooltipText = `NAME: ${point.name}\nSAFEZONE: ${point.safezone ? "YES" : "NO"}` +
                    `\nCAN SPAWN: ${point.canSpawn && SpawnCooldownManager.canSpawn(Players.LocalPlayer, point.name) ? "YES" : "NO"}` +
                    `\nCONTROLLING FACTION: ${controllingFaction}` +
                    `\nCOOLDOWN: ${point.canSpawn && !point.safezone ? math.clamp(SpawnCooldownManager.getCooldownSecsRemaining(Players.LocalPlayer, point.name), 0, math.huge) : "NONE"}`;
                if (newTooltipText !== tooltipText && !tooltipBindings.tooltipSelected.getValue()) {
                    tooltipBindings.setTooltipText(newTooltipText);
                    tooltipText = newTooltipText;
                }
                if (newMousePos !== mousePos && !tooltipBindings.tooltipSelected.getValue()) {
                    mousePos = newMousePos;
                    tooltipBindings.setTooltipPosition(mousePos);
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
        if (!tooltipBindings.tooltipSelected.getValue() && this.props.point.canSpawn && tooltipBindings && SpawnCooldownManager.canSpawn(Players.LocalPlayer, this.props.point.name)) {
            this.props.selectedPoint[1](this.props.point)
            tooltipBindings.setTooltipSelected(true);
            const mousePos = UserInputService.GetMouseLocation();
            if (!tooltipBindings.tooltip.getValue()) {
                tooltipBindings.setTooltip(true);
                tooltipBindings.setTooltipText(``);
            }
            tooltipBindings.setTooltipPosition(mousePos);
        } else if (tooltipBindings.tooltipSelected.getValue())
            tooltipBindings.setTooltipSelected(false);
    }
    render() {
        const borderColor = this.props.point.safezone ? Color3.fromRGB(92, 168, 255) : this.props.point.canSpawn ? Color3.fromRGB(255, 226, 86) : Color3.fromRGB(150, 150, 150);
        return <textbutton
            Key="Destination"
            BackgroundColor3={this.controllingFaction}
            BorderColor3={borderColor}
            BorderSizePixel={3}
            BorderMode={Enum.BorderMode.Inset}
            Font={Enum.Font.SourceSans}
            Position={this.position.add(UDim2.fromOffset(-7.5, -7.5))}
            Size={new UDim2(0, 15, 0, 15)}
            Text={""}
            TextColor3={Color3.fromRGB(0, 0, 0)}
            TextSize={10}
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
                Text={generateShortName(this.props.point.name)}
                Visible={this.props.point.canSpawn}
            />
        </textbutton>
    }
}