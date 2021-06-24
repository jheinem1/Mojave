import Roact from "@rbxts/roact";
import { Username } from "./username";

export class Health extends Roact.Component {
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
                    Key="Bar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Position={new UDim2(0, 0, 1, -2)}
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
                <frame
                    Key="HealthBar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Size={new UDim2(0.99, 0, 1, 0)}
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
        </frame>
    }
}