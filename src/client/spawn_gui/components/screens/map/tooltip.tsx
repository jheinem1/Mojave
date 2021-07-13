import Roact from "@rbxts/roact";

interface TooltipProps {
    position: Roact.Binding<Vector2>;
    visible: Roact.Binding<boolean>;
    text: Roact.Binding<string>;
    canSpawn: Roact.Binding<boolean>;
}

export class TooltipComponent extends Roact.Component<TooltipProps> {
    render() {
        return <frame
            Key="Tooltip"
            BackgroundColor3={Color3.fromRGB(126, 111, 42)}
            BorderColor3={Color3.fromRGB(255, 226, 86)}
            BorderSizePixel={3}
            Position={this.props.position.map(position => UDim2.fromScale(position.X, position.Y))}
            Size={new UDim2(0, 283, 0, 60)}
            Visible={this.props.visible}
        >
            <textlabel
                Key="DestinationInfo"
                BackgroundTransparency={1}
                Font={Enum.Font.SourceSansSemibold}
                Position={new UDim2(0, 5, 0, 0)}
                Size={new UDim2(1, -10, 1, 0)}
                Text={this.props.text}
                TextColor3={Color3.fromRGB(255, 226, 86)}
                TextSize={32}
                TextXAlignment={Enum.TextXAlignment.Left}
            />
            <frame
                Key="Tooltip"
                BackgroundColor3={Color3.fromRGB(126, 111, 42)}
                BorderColor3={Color3.fromRGB(255, 226, 86)}
                BorderSizePixel={3}
                Position={new UDim2(0, 0, 1, 3)}
                Size={new UDim2(0, 283, 0, 32)}
            >
                <textlabel
                    Key="SpawnButton"
                    BackgroundTransparency={1}
                    Font={Enum.Font.SourceSansBold}
                    Position={new UDim2(0, 5, 0, 0)}
                    Size={new UDim2(1, -10, 1, 0)}
                    Text="SPAWN"
                    TextColor3={Color3.fromRGB(255, 226, 86)}
                    TextSize={32}
                    Visible={this.props.canSpawn}
                />
            </frame>
        </frame>
    }
}