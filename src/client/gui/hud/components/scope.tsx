import Roact from "@rbxts/roact";

export class Scope extends Roact.Component {
    render() {
        return <imagelabel
            Key="ScopeOverlay"
            BackgroundTransparency={1}
            Image="rbxassetid://358324484"
            ImageColor3={Color3.fromRGB(0, 0, 0)}
            Position={new UDim2(0.5, -200, 0.5, -200)}
            Size={new UDim2(0, 400, 0, 400)}
            Visible={false}
            ZIndex={10}
        >
            <frame
                Key="Frame4"
                BackgroundColor3={Color3.fromRGB(0, 0, 0)}
                BorderSizePixel={0}
                Position={new UDim2(0.5, -1500, 1, 0)}
                Size={new UDim2(0, 3000, 0, 600)}
                ZIndex={10}
            />
            <frame
                Key="Frame3"
                BackgroundColor3={Color3.fromRGB(0, 0, 0)}
                BorderSizePixel={0}
                Position={new UDim2(0.5, -1500, 0, -600)}
                Size={new UDim2(0, 3000, 0, 600)}
                ZIndex={10}
            />
            <frame
                Key="Frame1"
                BackgroundColor3={Color3.fromRGB(0, 0, 0)}
                BorderSizePixel={0}
                Position={new UDim2(1, 0, 0.5, -1500)}
                Size={new UDim2(0, 600, 0, 3000)}
                ZIndex={10}
            />
            <frame
                Key="Frame2"
                BackgroundColor3={Color3.fromRGB(0, 0, 0)}
                BorderSizePixel={0}
                Position={new UDim2(0, -600, 0.5, -1500)}
                Size={new UDim2(0, 600, 0, 3000)}
                ZIndex={10}
            />
        </imagelabel>
    }
}