import Roact from "@rbxts/roact";

export class Compass extends Roact.Component {
    render() {
        return <frame
            Key="Compass"
            BackgroundTransparency={1}
            ClipsDescendants={true}
            Position={new UDim2(0.5, -135, 1, -54)}
            Size={new UDim2(0, 270, 0, 50)}
        >
            <frame
                Key="Bars"
                BackgroundTransparency={1}
                Position={new UDim2(0, 0, 0, 20)}
                Size={new UDim2(1, 0, 0, 12)}
            >
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
                    Key="Bar"
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
                <imagelabel
                    BackgroundTransparency={1}
                    Image="rbxassetid://99753110"
                    ImageColor3={Color3.fromRGB(255, 170, 0)}
                    ImageTransparency={0.7}
                    Position={new UDim2(0, 0, 0, -14)}
                    Rotation={180}
                    Size={new UDim2(1, 0, 0, 24)}
                />
            </frame>
            <frame
                Key="Compass"
                BackgroundTransparency={1}
                ClipsDescendants={true}
                Position={new UDim2(0, 0, 0, 32)}
                Size={new UDim2(1, 0, 0, 20)}
            >
                <textlabel
                    Key="N"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="N"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    ZIndex={2}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.Arial}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text="N"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextScaled={true}
                        TextSize={24}
                        TextWrapped={true}
                    >
                        <textlabel
                            Key="Shadow"
                            BackgroundTransparency={1}
                            Font={Enum.Font.Arial}
                            Position={new UDim2(0, 1, 0, 1)}
                            Size={new UDim2(1, 0, 1, 0)}
                            Text="N"
                            TextColor3={Color3.fromRGB(67, 67, 67)}
                            TextScaled={true}
                            TextSize={24}
                            TextWrapped={true}
                        />
                    </textlabel>
                </textlabel>
                <textlabel
                    Key="W"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(-1, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="W"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    ZIndex={2}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.Arial}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text="W"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextScaled={true}
                        TextSize={24}
                        TextWrapped={true}
                    >
                        <textlabel
                            Key="Shadow"
                            BackgroundTransparency={1}
                            Font={Enum.Font.Arial}
                            Position={new UDim2(0, 1, 0, 1)}
                            Size={new UDim2(1, 0, 1, 0)}
                            Text="W"
                            TextColor3={Color3.fromRGB(67, 67, 67)}
                            TextScaled={true}
                            TextSize={24}
                            TextWrapped={true}
                        />
                    </textlabel>
                </textlabel>
                <textlabel
                    Key="S"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(2, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="S"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    ZIndex={2}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.Arial}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text="S"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextScaled={true}
                        TextSize={24}
                        TextWrapped={true}
                    >
                        <textlabel
                            Key="Shadow"
                            BackgroundTransparency={1}
                            Font={Enum.Font.Arial}
                            Position={new UDim2(0, 1, 0, 1)}
                            Size={new UDim2(1, 0, 1, 0)}
                            Text="S"
                            TextColor3={Color3.fromRGB(67, 67, 67)}
                            TextScaled={true}
                            TextSize={24}
                            TextWrapped={true}
                        />
                    </textlabel>
                </textlabel>
                <textlabel
                    Key="E"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(1, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="E"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    ZIndex={2}
                >
                    <textlabel
                        Key="Shadow"
                        BackgroundTransparency={1}
                        Font={Enum.Font.Arial}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(1, 0, 1, 0)}
                        Text="E"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextScaled={true}
                        TextSize={24}
                        TextWrapped={true}
                    >
                        <textlabel
                            Key="Shadow"
                            BackgroundTransparency={1}
                            Font={Enum.Font.Arial}
                            Position={new UDim2(0, 1, 0, 1)}
                            Size={new UDim2(1, 0, 1, 0)}
                            Text="E"
                            TextColor3={Color3.fromRGB(67, 67, 67)}
                            TextScaled={true}
                            TextSize={24}
                            TextWrapped={true}
                        />
                    </textlabel>
                </textlabel>
                <textlabel
                    Key="SE"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(1.5, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="SE"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    Visible={false}
                    ZIndex={2}
                />
                <textlabel
                    Key="NE"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(0.5, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="NE"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    Visible={false}
                    ZIndex={2}
                />
                <textlabel
                    Key="SW"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(-1.5, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="SW"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    Visible={false}
                    ZIndex={2}
                />
                <textlabel
                    Key="NW"
                    BackgroundTransparency={1}
                    Font={Enum.Font.Arial}
                    Position={new UDim2(-0.5, 0, 0, 0)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="NW"
                    TextColor3={Color3.fromRGB(255, 170, 0)}
                    TextScaled={true}
                    TextSize={24}
                    TextTransparency={0.2}
                    TextWrapped={true}
                    Visible={false}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="Tickmark"
                BackgroundColor3={Color3.fromRGB(255, 63, 29)}
                Position={new UDim2(0, 10, 0, 18)}
                Size={new UDim2(0, 10, 0, 10)}
                Visible={false}
                ZIndex={3}
            >
                <frame
                    Key="Shadow"
                    BackgroundColor3={Color3.fromRGB(67, 67, 67)}
                    BorderSizePixel={0}
                    Position={new UDim2(0, 2, 0, 2)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
        </frame>
    }
}