import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { t } from "@rbxts/t";

interface CapsState {
    caps: string
}

export class Caps extends Roact.Component<{}, CapsState> {
    capsValue = Players.LocalPlayer.FindFirstChild("Data")?.FindFirstChild("Caps");
    state = { caps: (t.instanceIsA("NumberValue")(this.capsValue) ? tostring(this.capsValue.Value) : "N/A") };

    constructor(props: {}) {
        super(props);
        if (t.instanceIsA("NumberValue")(this.capsValue))
            this.capsValue.Changed.Connect(caps => this.setState({ caps: tostring(caps) }));
    }

    render() {
        return <frame Key="Caps" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            <imagelabel
                Key="CapsIcon"
                AnchorPoint={new Vector2(0.5, 0)}
                BackgroundTransparency={1}
                Image="rbxassetid://73202079"
                ImageColor3={Color3.fromRGB(255, 170, 0)}
                Position={new UDim2(0, 13, 1, -130)}
                Size={new UDim2(0, 25, 0, 25)}
                ZIndex={2}
            >
                <imagelabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Image="rbxassetid://1117379455"
                    ImageColor3={Color3.fromRGB(0, 0, 0)}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                />
                <textlabel
                    Key="Caps"
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(1, 5, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text={this.state.caps}
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextSize={20}
                    TextXAlignment={Enum.TextXAlignment.Left}
                    ZIndex={2}
                >
                    <textlabel
                        Key="Caps"
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text={this.state.caps}
                        TextColor3={new Color3(0, 0, 0)}
                        TextSize={20}
                        TextXAlignment={Enum.TextXAlignment.Left}
                    />
                </textlabel>
            </imagelabel>
        </frame>
    }
}