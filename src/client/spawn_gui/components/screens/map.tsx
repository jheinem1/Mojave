import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { ProgressItemComponent } from "./progress_item";
import { Screen } from "./screen";


interface MapProps {
    FinishedEvent: ObjectEvent<[]>;
}

class MapComponent extends Roact.Component<MapProps, {}> {
    render() {
        return <frame
            Key="Map"
            BackgroundColor3={Color3.fromRGB(126, 111, 42)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            <imagelabel
                Key="MapImage"
                BackgroundTransparency={1}
                Image="rbxassetid://7010013959"
                Position={new UDim2(0.5, -960, 0, 0)}
                ScaleType={Enum.ScaleType.Fit}
                Size={new UDim2(0, 1920, 1, 0)}
                SliceScale={0}
            >
                <textbutton
                    Key="Destination"
                    BackgroundColor3={Color3.fromRGB(193, 193, 193)}
                    BorderColor3={Color3.fromRGB(255, 226, 86)}
                    BorderSizePixel={5}
                    Font={Enum.Font.SourceSans}
                    Position={new UDim2(0.562, 0, 0.643, 0)}
                    Size={new UDim2(0, 25, 0, 25)}
                    Text={""}
                    TextColor3={Color3.fromRGB(0, 0, 0)}
                    TextSize={14}
                />
                <frame
                    Key="Tooltip"
                    BackgroundColor3={Color3.fromRGB(126, 111, 42)}
                    BorderColor3={Color3.fromRGB(255, 226, 86)}
                    BorderSizePixel={3}
                    Position={new UDim2(0, 1150, 0, 550)}
                    Size={new UDim2(0, 283, 0, 60)}
                >
                    <textlabel
                        Key="DestinationInfo"
                        BackgroundTransparency={1}
                        Font={Enum.Font.SourceSansSemibold}
                        Position={new UDim2(0, 5, 0, 0)}
                        Size={new UDim2(1, -10, 1, 0)}
                        Text={`Hoover Dam\nControlling Faction: NCR`}
                        TextColor3={Color3.fromRGB(255, 226, 86)}
                        TextSize={32}
                        TextXAlignment={Enum.TextXAlignment.Left}
                    />
                    <frame
                        Key="Tooltip"
                        BackgroundColor3={Color3.fromRGB(126, 111, 42)}
                        BorderColor3={Color3.fromRGB(255, 226, 86)}
                        BorderSizePixel={3}
                        Position={new UDim2(0, 0, 1, 3)}
                        Size={new UDim2(0, 283, 0, 32)}
                    >
                        <textlabel
                            Key="SpawnButton"
                            BackgroundTransparency={1}
                            Font={Enum.Font.SourceSansBold}
                            Position={new UDim2(0, 5, 0, 0)}
                            Size={new UDim2(1, -10, 1, 0)}
                            Text="SPAWN"
                            TextColor3={Color3.fromRGB(255, 226, 86)}
                            TextSize={32}
                        />
                    </frame>
                </frame>
            </imagelabel>
        </frame>
    }
}

export class MapScreen extends Screen {
    getScreenComponent(): Roact.Element {
        return <MapComponent
            FinishedEvent={this.finished}
        />;
    }
    getButtonComponent(): Roact.Element {
        return <ProgressItemComponent
            Name="Spawn"
            Position={this.position}
            DeselectEvent={this.deselected}
            SelectEvent={this.selected}
            Event={{
                Clicked: () => this.selected.Fire()
            }}
        />;
    }
}