import Roact from "@rbxts/roact";
import { ProgressItemComponent } from "../progress_item";
import { Screen } from "../screen";

class TeamsComponent extends Roact.Component {
    render() {
        return <frame
            Key="Teams"
            BackgroundColor3={Color3.fromRGB(255, 255, 255)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            <uilistlayout FillDirection={Enum.FillDirection.Horizontal} SortOrder={Enum.SortOrder.LayoutOrder} />
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateFull"
                BackgroundColor3={Color3.fromRGB(46, 46, 46)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.3, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
                <textlabel
                    Key="Faction"
                    BackgroundTransparency={1}
                    Font={Enum.Font.GothamSemibold}
                    Size={new UDim2(1, 0, 0.25, 0)}
                    Text="NCR"
                    TextColor3={Color3.fromRGB(255, 208, 80)}
                    TextScaled={true}
                    TextSize={100}
                    TextWrapped={true}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
            <frame
                Key="TeamTemplateMinimized"
                BackgroundColor3={Color3.fromRGB(23, 23, 23)}
                BorderSizePixel={0}
                ClipsDescendants={true}
                Size={new UDim2(0.1, 0, 1, 0)}
            >
                <viewportframe
                    Key="Avatar"
                    Ambient={Color3.fromRGB(106, 106, 106)}
                    BackgroundTransparency={1}
                    LightColor={Color3.fromRGB(255, 255, 255)}
                    LightDirection={new Vector3(2, -1, -1)}
                    Size={new UDim2(1, 0, 1, 0)}
                    ZIndex={2}
                />
            </frame>
        </frame>
    }
}

export class TeamsScreen extends Screen {
    name = "Teams";
    getScreenComponent(): Roact.Element {
        return <TeamsComponent />;
    }
}