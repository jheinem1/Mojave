import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Username } from "./username";

interface HealthState {
    health: number;
}

export class Health extends Roact.Component<{}, HealthState> {
    state = { health: 0 };

    constructor(props: {}) {
        super(props);
        Players.LocalPlayer.CharacterAdded.Connect(character => this.onCharacter(character));
        const existingCharacter = Players.LocalPlayer.Character;
        if (existingCharacter)
            this.onCharacter(existingCharacter);
    }

    onCharacter(character: Model) {
        const humanoid = character.FindFirstChildOfClass("Humanoid") ?? character.WaitForChild("Humanoid", 5);
        if (t.instanceOf("Humanoid")(humanoid)) {
            humanoid.GetPropertyChangedSignal("Health").Connect(() => this.setState({ health: humanoid.Health }));
            this.setState({ health: humanoid.Health });
        }
    }

    render() {
        return <frame
            Key="Health"
            BackgroundTransparency={1}
            Position={new UDim2(0, 4, 1, -46)}
            Size={new UDim2(0, 245, 0, 40)}
        >
            <textlabel
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Size={new UDim2(0, 35, 0, 40)}
                Text="HP"
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
            >
                <textlabel
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(0, 35, 0, 40)}
                    Text="HP"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(0, 35, 0, 40)}
                        Text="HP"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={24}
                    />
                </textlabel>
            </textlabel>
            <frame
                Key="Bars"
                BackgroundTransparency={1}
                Position={new UDim2(0, 35, 0, 10)}
                Size={new UDim2(0, 200, 0, 10)}
            >
                <frame
                    Key="RightBar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Position={new UDim2(1, -2, 0, 0)}
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
                    Key="LeftBar"
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
                    Key="BottomBar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Size={new UDim2(1, 0, 0, 2)}
                    Position={new UDim2(0, 0, 1, 0)}
                    ZIndex={3}
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
                    Key="HealthBar"
                    BackgroundColor3={this.state.health > 100 ? new Color3(0, 0.35, 1) : Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Size={new UDim2(math.clamp(this.state.health / 100, 0, 1), -math.clamp(this.state.health / 100 * 4, 0, 4), 1, 0)}
                    Position={new UDim2(0, 2, 0, 0)}
                    ZIndex={3}
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
                    Key="RadsBar"
                    BackgroundColor3={Color3.fromRGB(255, 91, 58)}
                    BorderSizePixel={0}
                    Position={new UDim2(0.9, 0, 0, 0)}
                    Size={new UDim2(0.1, 0, 1, 0)}
                    Visible={false}
                    ZIndex={3}
                />
                <frame
                    Key="Bar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Position={new UDim2(1, -2, 0, 0)}
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
            </frame>
            <textlabel
                Key="RadsAmount"
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Position={new UDim2(1, -110, 0, -26)}
                Size={new UDim2(0, 100, 0, 40)}
                Text="+1 RADS"
                TextColor3={Color3.fromRGB(255, 0, 0)}
                TextSize={24}
                TextXAlignment={Enum.TextXAlignment.Right}
                Visible={false}
                ZIndex={2}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(0, 100, 0, 40)}
                    Text="+1 RADS"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                    TextXAlignment={Enum.TextXAlignment.Right}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(0, 100, 0, 40)}
                        Text="+1 RADS"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={24}
                        TextXAlignment={Enum.TextXAlignment.Right}
                    />
                </textlabel>
            </textlabel>
            <imagelabel
                Key="RadIcon"
                BackgroundTransparency={1}
                Image="rbxassetid://339643706"
                ImageColor3={Color3.fromRGB(255, 50, 23)}
                Position={new UDim2(1, 0, 0, -20)}
                Size={new UDim2(0, 40, 0, 40)}
                Visible={false}
                ZIndex={2}
            >
                <imagelabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Image="rbxassetid://339643706"
                    ImageColor3={Color3.fromRGB(67, 67, 67)}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(0, 40, 0, 40)}
                >
                    <imagelabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Image="rbxassetid://339643706"
                        ImageColor3={Color3.fromRGB(67, 67, 67)}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(0, 40, 0, 40)}
                    />
                </imagelabel>
            </imagelabel>
            <Username />
        </frame >
    }
}