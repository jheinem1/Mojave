import Roact from "@rbxts/roact";

export class Tool extends Roact.Component {
    render() {
        return <frame
            Key="Ammo"
            BackgroundTransparency={1}
            Position={new UDim2(1, -106, 1, -136)}
            Size={new UDim2(0, 100, 0, 80)}
        >
            <textlabel
                Key="MagAmmo"
                BackgroundTransparency={1}
                Size={new UDim2(1, 0, 0, 40)}
                Text="100"
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 0, 40)}
                    Text="100"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 0, 40)}
                        Text="100"
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
                Text="100"
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 0, 40)}
                    Text="100"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 0, 40)}
                        Text="100"
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
                Text="Assault Rifle"
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
                    Text="Assault Rifle"
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
                        Text="Assault Rifle"
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