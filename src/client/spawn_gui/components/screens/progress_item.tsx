import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";

interface ProgressItemProps {
    Name: string;
    Position: number;
    DeselectEvent: ObjectEvent<[]>;
    SelectEvent: ObjectEvent<[]>;
    Event: {
        Clicked: () => void;
    };
}

interface ProgressItemState {
    selected: boolean;
}

export class ProgressItemComponent extends Roact.Component<ProgressItemProps, ProgressItemState> {
    state = {
        selected: false
    }
    constructor(props: ProgressItemProps) {
        super(props);
        props.DeselectEvent.Connect(() => this.setState({ selected: false }));
        props.SelectEvent.Connect(() => this.setState({ selected: true }));
    }
    render() {
        return <textbutton
            Key={tostring(this.props.Name)}
            BackgroundTransparency={1}
            Font={Enum.Font.SourceSansBold}
            LayoutOrder={this.props.Position}
            Position={new UDim2(0, 70, 0, 0)}
            Size={new UDim2(0.2, 0, 0, 36)}
            Text={tostring(this.props.Name)}
            TextColor3={this.state.selected ? Color3.fromRGB(255, 255, 255) : Color3.fromRGB(172, 172, 172)}
            TextScaled={true}
            TextSize={24}
            TextWrapped={true}
            Event={{
                MouseButton1Click: () => this.props.SelectEvent.Fire()
            }}
        />
    }
}