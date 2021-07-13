import Roact from "@rbxts/roact";
import { ClientFaction } from "shared/faction_manager/faction";

interface MapPointComponentProps {
    position: Roact.Binding<Vector2>;
    controlling?: Roact.Binding<ClientFaction>;
}

export class MapPointComponent extends Roact.Component<MapPointComponentProps> {
    render() {
        return <textbutton
            Key="Destination"
            BackgroundColor3={this.props.controlling ? this.props.controlling.map(faction => faction.color.Color) : new Color3(0.5, 0.5, 0.5)}
            BorderColor3={Color3.fromRGB(255, 226, 86)}
            BorderSizePixel={5}
            Font={Enum.Font.SourceSans}
            Position={this.props.position.map(position => UDim2.fromOffset(position.X, position.Y))}
            Size={new UDim2(0, 25, 0, 25)}
            Text={""}
            TextColor3={Color3.fromRGB(0, 0, 0)}
            TextSize={14}
        />
    }
}