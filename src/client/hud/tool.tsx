import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { t } from "@rbxts/t";

interface ToolState {
    toolEquipped: boolean;
    toolName: string;
    hasGun: boolean;
    ammo: string;
    maxAmmo: string;
}

export class ToolComponent extends Roact.Component<{}, ToolState> {
    state = {
        toolEquipped: false,
        toolName: "",
        hasGun: false,
        ammo: "",
        maxAmmo: ""
    }

    constructor(props: {}) {
        super(props);
        Players.LocalPlayer.CharacterAdded.Connect(character => this.onCharacter(character));
        if (Players.LocalPlayer.Character)
            this.onCharacter(Players.LocalPlayer.Character);
    }

    private onCharacter(character: Model) {
        character.ChildAdded.Connect(child => {
            if (child.IsA("Tool"))
                this.onToolChange(character, child);
        })
        const existingTool = character.FindFirstChildOfClass("Tool");
        if (existingTool)
            this.onToolChange(character, existingTool);
    }

    private onToolChange(character: Model, tool: Tool) {
        if (tool.FindFirstChild("BlasterSettings")) {
            const ammo = tool.FindFirstChild("ammo");
            const maxAmmo = tool.FindFirstChild("BlasterSettings")?.FindFirstChild("Stats")?.FindFirstChild("MaxAmmo");
            this.setState({
                //@ts-ignore (idk it gets mad here even though it shouldn't)
                toolEquipped: true,
                toolName: tool.Name,
                hasGun: true,
                ammo: t.instanceOf("NumberValue")(ammo) ? tostring(ammo.Value) : "N/A",
                maxAmmo: t.instanceOf("NumberValue")(maxAmmo) ? tostring(maxAmmo.Value) : "N/A",
            });
        } else {
            this.setState({
                toolEquipped: true,
                toolName: tool.Name,
                hasGun: false
            })
        }
        tool.AncestryChanged.Connect(() => {
            if (tool.Parent !== character) {
                this.setState({
                    toolEquipped: false
                });
                const newTool = character.FindFirstChildOfClass("Tool");
                if (newTool)
                    this.onToolChange(character, newTool);
            }
        });
    }

    render() {
        return <frame
            Key="Ammo"
            BackgroundTransparency={1}
            Position={new UDim2(1, -106, 1, -136)}
            Size={new UDim2(0, 100, 0, 80)}
            Visible={this.state.toolEquipped}
        >
            <textlabel
                Key="MagAmmo"
                BackgroundTransparency={1}
                Size={new UDim2(1, 0, 0, 40)}
                Text={this.state.ammo}
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
                Visible={this.state.hasGun}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 0, 40)}
                    Text={this.state.ammo}
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 0, 40)}
                        Text={this.state.ammo}
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={24}
                    />
                </textlabel>
            </textlabel>
            <textlabel
                Key="TotalAmmo"
                BackgroundTransparency={1}
                Position={new UDim2(0, 0, 0, 40)}
                Size={new UDim2(1, 0, 0, 40)}
                Text={this.state.maxAmmo}
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
                Visible={this.state.hasGun}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 0, 40)}
                    Text={this.state.maxAmmo}
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 0, 40)}
                        Text={this.state.maxAmmo}
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={24}
                    />
                </textlabel>
            </textlabel>
            <frame
                Key="Bar"
                BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                BorderSizePixel={0}
                Position={new UDim2(0.5, -34, 0.5, -1)}
                Size={new UDim2(0, 70, 0, 2)}
                ZIndex={3}
                Visible={this.state.hasGun}
            >
                <frame
                    Key="Bar"
                    BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                    BorderSizePixel={0}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                >
                    <frame
                        Key="Bar"
                        BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                        BorderSizePixel={0}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                    />
                </frame>
            </frame>
            <textlabel
                Key="ToolName"
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Position={new UDim2(0, -10, 1, 0)}
                Size={new UDim2(0, 100, 0, 10)}
                Text={this.state.toolName}
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={18}
                TextXAlignment={Enum.TextXAlignment.Right}
                ZIndex={2}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text={this.state.toolName}
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={18}
                    TextXAlignment={Enum.TextXAlignment.Right}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text={this.state.toolName}
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={18}
                        TextXAlignment={Enum.TextXAlignment.Right}
                    />
                </textlabel>
            </textlabel>
            <imagelabel
                Key="FiringModeIcon"
                BackgroundTransparency={1}
                Image="rbxassetid://358920621"
                ImageColor3={Color3.fromRGB(255, 170, 0)}
                ImageRectOffset={new Vector2(0, 156)}
                ImageRectSize={new Vector2(144, 156)}
                Position={new UDim2(0, -10, 0.5, -10)}
                Size={new UDim2(0, 20, 0, 20)}
                ZIndex={2}
                Visible={this.state.hasGun}
            >
                <imagelabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Image="rbxassetid://358920621"
                    ImageColor3={Color3.fromRGB(67, 67, 67)}
                    ImageRectOffset={new Vector2(0, 156)}
                    ImageRectSize={new Vector2(144, 156)}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                >
                    <imagelabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Image="rbxassetid://358920621"
                        ImageColor3={Color3.fromRGB(67, 67, 67)}
                        ImageRectOffset={new Vector2(0, 156)}
                        ImageRectSize={new Vector2(144, 156)}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                    />
                </imagelabel>
            </imagelabel>
        </frame>
    }
}