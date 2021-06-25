import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { t } from "@rbxts/t";

export class Settings extends Roact.Component {
    private settings = Players.LocalPlayer.FindFirstChild("PlayerGui")?.FindFirstChild("Settings") ?? Players.LocalPlayer.WaitForChild("PlayerGui", 5)?.WaitForChild("Settings", 5);

    constructor(props: {}) {
        super(props);
        if (t.instanceIsA("ScreenGui")(this.settings))
            this.settings.ResetOnSpawn = false
    }

    render() {
        return <frame Key="Settings" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            <imagebutton
                Key="Left"
                Active={false}
                BackgroundTransparency={1}
                Image="http://www.roblox.com/asset/?id=4677859281"
                ImageColor3={Color3.fromRGB(255, 170, 0)}
                Position={new UDim2(0, 0, 1, -100)}
                Size={new UDim2(0, 30, 0, 30)}
                Selectable={false}
                ZIndex={2}
                Event={{
                    MouseButton1Click: () => {
                        if (this.settings?.IsA("ScreenGui"))
                            this.settings.Enabled = !this.settings.Enabled;
                        else
                            throw "Settings not found!";
                    }
                }}
            >
                <imagebutton
                    Key="Shadow"
                    Active={false}
                    BackgroundTransparency={1}
                    Image="http://www.roblox.com/asset/?id=4677859281"
                    ImageColor3={new Color3(0, 0, 0)}
                    Position={new UDim2(0, 1, 0, 1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    Selectable={false}
                />
            </imagebutton>
        </frame>
    }
}