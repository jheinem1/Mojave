import Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";
import Remotes from "shared/remotes";

const inSafezone = Remotes.Client.Get("InSafezone");

interface safezoneElementProps {
    Visible: boolean;
}
function safezoneElement(props: safezoneElementProps) {
    return <screengui ResetOnSpawn={false} Enabled={props.Visible}>
        <textlabel
            Text="[SAFEZONE]"
            TextColor3={new Color3(1, 1, 1)}
            TextStrokeTransparency={0}
            TextScaled={true}
            BackgroundTransparency={1}
            Size={UDim2.fromScale(1, 0.05)}
        />
    </screengui>
}
const safezoneElementHandle = Roact.mount(
    safezoneElement({ Visible: false }),
    Players.LocalPlayer.WaitForChild("PlayerGui", 5) ?? error("PlayerGui not found for some reason???")
);

inSafezone.Connect((isInSafezone) => Roact.update(safezoneElementHandle, safezoneElement({ Visible: isInSafezone })));