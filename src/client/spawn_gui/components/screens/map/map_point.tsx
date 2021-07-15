import Roact from "@rbxts/roact";
import { ClientFaction } from "shared/faction_manager/faction";
import { Point } from "shared/map/point";

interface MapPointComponentProps {
    point: Point;
    size: Vector2;
    controlling?: Roact.Binding<ClientFaction>;
}

export class MapPointComponent extends Roact.Component<MapPointComponentProps> {
    position: UDim2;
    constructor(props: MapPointComponentProps) {
        super(props);
        print(props.point.position, props.size)
        const relPosition = new Vector2(props.point.position.X / props.size.X, props.point.position.Y / props.size.Y);
        this.position = UDim2.fromScale(relPosition.X, relPosition.Y);
    }
    render() {
        return <textbutton
            Key="Destination"
            BackgroundColor3={this.props.controlling ? this.props.controlling.map(faction => faction.color.Color) : new Color3(0.5, 0.5, 0.5)}
            BorderColor3={Color3.fromRGB(255, 226, 86)}
            BorderSizePixel={5}
            Font={Enum.Font.SourceSans}
            Position={this.position}
            Size={new UDim2(0, 25, 0, 25)}
            Text={""}
            TextColor3={Color3.fromRGB(0, 0, 0)}
            TextSize={14}
        />
    }
}