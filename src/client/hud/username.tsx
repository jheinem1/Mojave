import Roact from "@rbxts/roact";

export class Username extends Roact.Component {
    render() {
        return <textlabel
            Key="Username"
            BackgroundTransparency={1}
            ClipsDescendants={true}
            Font={Enum.Font.SourceSansBold}
            Position={new UDim2(0, 0, 0, -14)}
            Size={new UDim2(0, 140, 0, 20)}
            Text="ghoulbait"
            TextColor3={Color3.fromRGB(255, 170, 0)}
            TextScaled={true}
            TextSize={14}
            TextWrapped={true}
            TextXAlignment={Enum.TextXAlignment.Left}
            TextYAlignment={Enum.TextYAlignment.Bottom}
            ZIndex={2}
        >
            <textlabel
                Key="Shadow"
                BackgroundTransparency={1}
                Font={Enum.Font.SourceSansBold}
                Position={new UDim2(0, 1, 0, 1)}
                Size={new UDim2(1, 0, 1, 0)}
                Text="ghoulbait"
                TextColor3={Color3.fromRGB(67, 67, 67)}
                TextScaled={true}
                TextSize={14}
                TextWrapped={true}
                TextXAlignment={Enum.TextXAlignment.Left}
                TextYAlignment={Enum.TextYAlignment.Bottom}
            >
                <textlabel
                    Key="Shadow"
                    BackgroundTransparency={1}
                    Font={Enum.Font.SourceSansBold}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Text="ghoulbait"
                    TextColor3={Color3.fromRGB(67, 67, 67)}
                    TextScaled={true}
                    TextSize={14}
                    TextWrapped={true}
                    TextXAlignment={Enum.TextXAlignment.Left}
                    TextYAlignment={Enum.TextYAlignment.Bottom}
                />
            </textlabel>
        </textlabel>
    }
}