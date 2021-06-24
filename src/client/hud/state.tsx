import Roact from "@rbxts/roact";
import Remotes from "shared/remotes";

interface StateState {
    safe: boolean;
}
export class State extends Roact.Component<{}, StateState> {
    state = { safe: false };

    constructor(props: {}) {
        super(props);
        Remotes.Client.Get("InSafezone").Connect(safe => this.setState({ safe: safe }));
    }

    render() {
        return <frame
            Key="Safezone"
            BackgroundTransparency={1}
            ClipsDescendants={true}
            Position={new UDim2(0, 4, 0, 4)}
            Size={new UDim2(0, 230, 0, 35)}
            Visible={this.state.safe}
        >
            <frame
                Key="Bottom_Bars"
                BackgroundTransparency={1}
                Position={new UDim2(0, 0, 1, -12)}
                Size={new UDim2(1, 0, 0, 12)}
            />
            <textlabel
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Position={new UDim2(0, 5, 0, 5)}
                Size={new UDim2(0, 220, 0, 25)}
                Text="YOU ARE IN A SAFE ZONE."
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextScaled={true}
                TextSize={18}
                TextWrapped={true}
                TextXAlignment={Enum.TextXAlignment.Left}
                TextYAlignment={Enum.TextYAlignment.Top}
                ZIndex={2}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="YOU ARE IN A SAFE ZONE."
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextScaled={true}
                    TextSize={18}
                    TextWrapped={true}
                    TextXAlignment={Enum.TextXAlignment.Left}
                    TextYAlignment={Enum.TextYAlignment.Top}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text="YOU ARE IN A SAFE ZONE."
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextScaled={true}
                        TextSize={18}
                        TextWrapped={true}
                        TextXAlignment={Enum.TextXAlignment.Left}
                        TextYAlignment={Enum.TextYAlignment.Top}
                    />
                </textlabel>
            </textlabel>
            <frame
                Key="Top_Left"
                BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                BorderSizePixel={0}
                Size={new UDim2(0, 2, 1, 0)}
                ZIndex={4}
            >
                <frame
                    Key="Bar"
                    BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                    BorderSizePixel={0}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                >
                    <frame
                        Key="Bar"
                        BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                        BorderSizePixel={0}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        ZIndex={2}
                    />
                </frame>
            </frame>
            <frame
                Key="Top"
                BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                BorderSizePixel={0}
                Size={new UDim2(1, 0, 0, 2)}
                ZIndex={4}
            >
                <frame
                    Key="Bar"
                    BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                    BorderSizePixel={0}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                >
                    <frame
                        Key="Bar"
                        BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                        BorderSizePixel={0}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        ZIndex={2}
                    />
                </frame>
            </frame>
        </frame>
    }
}