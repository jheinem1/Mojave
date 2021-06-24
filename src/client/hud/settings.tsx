import Roact from "@rbxts/roact";

export class Settings extends Roact.Component {
    render() {
        return <frame Key="Settings" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            <imagebutton
                Key="Left"
                Active={false}
                BackgroundTransparency={1}
                Image="http://www.roblox.com/asset/?id=4677859281"
                ImageColor3={Color3.fromRGB(255, 170, 0)}
                Position={new UDim2(0.001, 0, 0.805, 0)}
                Selectable={false}
                Size={new UDim2(0.03, 0, 0.054, 0)}
                ZIndex={50}
            />
        </frame>
    }
}