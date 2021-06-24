import Roact from "@rbxts/roact";

export class Caps extends Roact.Component {
    render() {
        return <frame Key="Caps" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            <imagelabel
                Key="CapsIcon"
                AnchorPoint={new Vector2(0.5, 0)}
                BackgroundTransparency={1}
                Image="rbxassetid://73202079"
                ImageColor3={Color3.fromRGB(255, 170, 0)}
                Position={new UDim2(0.017, 0, 0.872, 0)}
                Size={new UDim2(0.027, 0, 0.048, 0)}
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
            </imagelabel>
            <textlabel
                Key="Caps"
                BackgroundTransparency={1}
                Font={Enum.Font.ArialBold}
                Position={new UDim2(0.038, 0, 0.891, 0)}
                Size={new UDim2(0.052, 0, 0.02, 0)}
                Text="0"
                TextColor3={Color3.fromRGB(255, 170, 0)}
                TextSize={20}
                TextStrokeTransparency={0.5}
                TextXAlignment={Enum.TextXAlignment.Left}
                ZIndex={2}
            />
        </frame>
    }
}