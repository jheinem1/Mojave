import Roact from "@rbxts/roact";

export class ActionPoints extends Roact.Component {
    render() {
        return <frame
            Key="ActionPoints"
            BackgroundTransparency={1}
            Position={new UDim2(1, -240, 1, -46)}
            Size={new UDim2(0, 235, 0, 40)}
        >
            <textlabel
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Position={new UDim2(1, -35, 0, 0)}
                Size={new UDim2(0, 35, 0, 40)}
                Text="AP"
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={24}
                ZIndex={2}
            >
                <textlabel
                    BackgroundTransparency={1}
                    Font={Enum.Font.ArialBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(0, 35, 0, 40)}
                    Text="AP"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextSize={24}
                >
                    <textlabel
                        BackgroundTransparency={1}
                        Font={Enum.Font.ArialBold}
                        Position={new UDim2(0, 1, 0, 1)}
                        Size={new UDim2(0, 35, 0, 40)}
                        Text="AP"
                        TextColor3={Color3.fromRGB(67, 67, 67)}
                        TextSize={24}
                    />
                </textlabel>
            </textlabel>
            <frame
                Key="Bars"
                BackgroundTransparency={1}
                Position={new UDim2(0, 0, 0, 10)}
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
                    Key="ActionBar"
                    BackgroundColor3={Color3.fromRGB(255, 170, 0)}
                    BorderSizePixel={0}
                    Size={new UDim2(1, 0, 1, 0)}
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
                {/* <frame
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
                </frame> */}
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
            </frame>
        </frame>
    }
}