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
    size = new Vector2(250, 10);
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
            BorderSizePixel={2}
            Position={tooltipBindings.tooltipPosition.map(cursor => {
                const viewportSize = Workspace.CurrentCamera?.ViewportSize;
                if (viewportSize) {
                    cursor = cursor.add(new Vector2(0, -36))
                    const size = this.size;
                    const spawnButtonSizeY = this.tooltipBindings.tooltipSelected.getValue() ? 20 : 0;
                    let position = new Vector2(cursor.X + 5, cursor.Y - size.Y - spawnButtonSizeY - 5);
                    if (position.X + size.X + 2 > viewportSize.X)
                        position = new Vector2(viewportSize.X - size.X, position.Y);
                    if (position.Y < 0)
                        position = new Vector2(position.X, 0);
                    if (position.Y + size.Y + spawnButtonSizeY >= cursor.Y) {
                        position = new Vector2(position.X, cursor.Y + 5);
                        if (position.Y + size.Y + spawnButtonSizeY > viewportSize.Y)
                            position = new Vector2(position.X, viewportSize.Y - size.Y - spawnButtonSizeY);
                    }
                    return UDim2.fromOffset(position.X, position.Y);
                } else
                    return new UDim2();
            })}
            Size={this.tooltipBindings.tooltipText.map(text => {
                let textSize = TextService.GetTextSize(text, 18, Enum.Font.SourceSans, new Vector2(this.size.X, math.huge));
                textSize = new Vector2(this.size.X, textSize.Y + 10)
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
                TextSize={18}
                TextXAlignment={Enum.TextXAlignment.Left}
                TextWrapped={true}
            />
            <frame
                Key="Tooltip"
                BackgroundColor3={Color3.fromRGB(126, 111, 42)}
                BorderColor3={Color3.fromRGB(255, 226, 86)}
                BorderSizePixel={2}
                Position={new UDim2(0, 0, 1, 0)}
                Size={new UDim2(1, 0, 0, 20)}
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
                    TextSize={16}
                    AutoButtonColor={false}
                    Event={{
                        MouseButton1Click: () => this.props.event?.onSpawn ? this.props.event?.onSpawn() : undefined
                    }}
                />
            </frame>
        </frame>
    }
}