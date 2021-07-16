import Roact from "@rbxts/roact";
import { TextService, Workspace } from "@rbxts/services";

export interface TooltipBindings {
    tooltip: Roact.Binding<boolean>;
    setTooltip: (visible: boolean) => void;
    tooltipText: Roact.Binding<string>;
    setTooltipText: (text: string) => void;
    tooltipPosition: Roact.Binding<Vector2>;
    setTooltipPosition: (position: Vector2) => void;
    tooltipSelected: Roact.Binding<boolean>;
    setTooltipSelected: (selected: boolean) => void;
}

interface TooltipProps {
    tooltipBindings: TooltipBindings;
    event?: {
        onSpawn?: () => void;
    }
}

export class TooltipComponent extends Roact.Component<TooltipProps> {
    tooltipBindings: TooltipBindings;
    size = new Vector2(290, 10);
    ref = Roact.createRef<Frame>();
    constructor(props: TooltipProps) {
        super(props);
        this.tooltipBindings = props.tooltipBindings;
    }
    render() {
        const tooltipBindings = this.tooltipBindings;
        return <frame
            Key="Tooltip"
            BackgroundColor3={Color3.fromRGB(126, 111, 42)}
            BorderColor3={Color3.fromRGB(255, 226, 86)}
            BorderSizePixel={3}
            Position={tooltipBindings.tooltipPosition.map(cursor => {
                const viewportSize = Workspace.CurrentCamera?.ViewportSize;
                if (viewportSize) {
                    const size = this.size;
                    const spawnButtonSizeY = this.tooltipBindings.tooltipSelected.getValue() ? 32 : 0
                    let position = new Vector2(math.clamp(cursor.X + 5, 0, viewportSize.X - size.X), math.clamp(cursor.Y - size.Y - 5 - spawnButtonSizeY, 0, cursor.Y - size.Y - spawnButtonSizeY));
                    if (position.Y < 0 || position.Y + size.Y > viewportSize.Y - size.Y - spawnButtonSizeY)
                        position = new Vector2(position.X, math.clamp(cursor.Y + 5, cursor.Y, viewportSize.Y - size.Y - spawnButtonSizeY))
                    return UDim2.fromOffset(position.X, position.Y);
                } else
                    return new UDim2();
            })}
            Size={this.tooltipBindings.tooltipText.map(text => {
                let textSize = TextService.GetTextSize(text, 12, Enum.Font.SourceSans, new Vector2(290, math.huge));
                textSize = textSize.add(new Vector2(10, 10));
                this.size = textSize;
                return UDim2.fromOffset(textSize.X, textSize.Y);
            })}
            Visible={tooltipBindings.tooltip}
            ZIndex={2}
            Ref={this.ref}
        >
            <textlabel
                Key="DestinationInfo"
                BackgroundTransparency={1}
                Font={Enum.Font.SourceSans}
                Position={new UDim2(0, 5, 0, 0)}
                Size={new UDim2(1, -10, 1, 0)}
                Text={tooltipBindings.tooltipText}
                TextColor3={Color3.fromRGB(255, 226, 86)}
                TextSize={12}
                TextXAlignment={Enum.TextXAlignment.Left}
            />
            <frame
                Key="Tooltip"
                BackgroundColor3={Color3.fromRGB(126, 111, 42)}
                BorderColor3={Color3.fromRGB(255, 226, 86)}
                BorderSizePixel={3}
                Position={new UDim2(0, 0, 1, 3)}
                Size={new UDim2(1, 0, 0, 32)}
                Visible={tooltipBindings.tooltipSelected}
            >
                <textbutton
                    Key="SpawnButton"
                    BackgroundTransparency={1}
                    Font={Enum.Font.SourceSansBold}
                    Position={new UDim2(0, 5, 0, 0)}
                    Size={new UDim2(1, -10, 1, 0)}
                    Text="SPAWN"
                    TextColor3={Color3.fromRGB(255, 226, 86)}
                    TextSize={32}
                    AutoButtonColor={false}
                    Event={{
                        MouseButton1Click: () => this.props.event?.onSpawn ? this.props.event?.onSpawn() : undefined
                    }}
                />
            </frame>
        </frame>
    }
}