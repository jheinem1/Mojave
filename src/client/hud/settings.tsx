import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";

export class Settings extends Roact.Component {
    private settings = Players.LocalPlayer.FindFirstChildOfClass("PlayerGui")?.FindFirstChild("Settings");

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
                Event={{
                    MouseButton1Click: () => {
                        if (this.settings?.IsA("ScreenGui"))
                            this.settings.Enabled = !this.settings.Enabled;
                        else
                            throw "Settings not found!";
                    }
                }}
            />
        </frame>
    }
}