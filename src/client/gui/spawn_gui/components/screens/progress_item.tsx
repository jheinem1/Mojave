import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";

interface ProgressItemProps {
    name: string;
    position: number;
    startSelected: boolean;
    deselectEvent: ObjectEvent<[]>;
    selected: Roact.Binding<number>;
    updateSelection: (selection: number) => void;
}

export class ProgressItemComponent extends Roact.Component<ProgressItemProps> {
    constructor(props: ProgressItemProps) {
        super(props);
        this.state = { selected: props.startSelected };
    }
    render() {
        return <textbutton
            Key={tostring(this.props.name)}
            BackgroundTransparency={1}
            Font={Enum.Font.SourceSansBold}
            LayoutOrder={this.props.position}
            Position={new UDim2(0, 70, 0, 0)}
            Size={new UDim2(0.2, 0, 0, 36)}
            Text={tostring(this.props.name)}
            TextColor3={this.props.selected.map(currentScreen => currentScreen === this.props.position ? Color3.fromRGB(255, 255, 255) : Color3.fromRGB(172, 172, 172))}
            TextScaled={true}
            TextSize={24}
            TextWrapped={true}
            Event={{
                MouseButton1Click: () => this.props.updateSelection(this.props.position)
            }}
        />
    }
}