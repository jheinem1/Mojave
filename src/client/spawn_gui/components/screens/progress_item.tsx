import Roact from "@rbxts/roact";

interface Props {
    name: string;
    selected: boolean;
    order: number;
    Event: {
        MouseButton1Click: () => void;
    };
}

export class ProgressItemComponent extends Roact.Component<Props, {}> {
    render() {
        return <textbutton
            Key={tostring(this.props.name)}
            BackgroundTransparency={1}
            Font={Enum.Font.SourceSansBold}
            LayoutOrder={this.props.order}
            Position={new UDim2(0, 70, 0, 0)}
            Size={new UDim2(0.2, 0, 0, 36)}
            Text={tostring(this.props.name)}
            TextColor3={this.props.selected ? Color3.fromRGB(255, 255, 255) : Color3.fromRGB(172, 172, 172)}
            TextScaled={true}
            TextSize={24}
            TextWrapped={true}
            Event={this.props.Event}
        />
    }
}