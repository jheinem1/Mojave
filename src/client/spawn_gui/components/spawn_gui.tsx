import Roact from "@rbxts/roact";
import { ProgressComponent } from "./progress";
import { ProgressItemComponent } from "./screens/progress_item";

export class SpawnGuiComponent extends Roact.Component {
    render() {
        return <screengui Key="StartMenu" IgnoreGuiInset={true} ZIndexBehavior={Enum.ZIndexBehavior.Sibling}>
            <frame
                Key="Background"
                BackgroundColor3={Color3.fromRGB(0, 0, 0)}
                BorderSizePixel={0}
                Size={new UDim2(1, 0, 1, 0)}
            >
                <textlabel
                    Key="Title"
                    BackgroundTransparency={1}
                    Font={Enum.Font.SourceSansBold}
                    Position={new UDim2(0, 70, 0, 0)}
                    Size={new UDim2(0.3, 0, 0, 36)}
                    Text="MOJAVE WASTELANDS"
                    TextColor3={Color3.fromRGB(255, 255, 255)}
                    TextScaled={true}
                    TextSize={24}
                    TextWrapped={true}
                    TextXAlignment={Enum.TextXAlignment.Left}
                />

            </frame>
        </screengui>
    }
}