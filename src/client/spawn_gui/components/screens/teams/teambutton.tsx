import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";

interface TeamButtonProps {
    Name: string;
    Avatar: Roact.Element;
    StartSize: number;
    SelectedEvent: ObjectEvent<[number]>;
    DeselectedEvent: ObjectEvent<[number]>;
    Event?: {
        TeamSelected?: (name: string) => void;
    }
}

interface TeamButtonState {
    selected: boolean;
    minSize: number;
}

export class TeamButtonComponent extends Roact.Component<TeamButtonProps, TeamButtonState> {
    constructor(props: TeamButtonProps) {
        super(props);
        this.state = {
            minSize: props.StartSize,
            selected: false
        };
        props.SelectedEvent.Connect(newSize => this.setState({
            minSize: newSize,
            selected: true
        }));
        props.DeselectedEvent.Connect(newSize => this.setState({
            minSize: newSize,
            selected: false
        }));
    }
    render() {
        return <textbutton
            Key={this.props.Name}
            BackgroundColor3={this.state.selected ? Color3.fromRGB(46, 46, 46) : Color3.fromRGB(23, 23, 23)}
            BorderSizePixel={0}
            ClipsDescendants={true}
            Size={new UDim2(this.state.selected ? this.state.minSize * 3 : this.state.minSize, 0, 1, 0)}
            Text=""
        >
            <textlabel
                Key="Faction"
                BackgroundTransparency={1}
                Size={new UDim2(1, 0, 0.25, 0)}
                Visible={this.state.selected}
                Font={Enum.Font.GothamSemibold}
                Text={this.props.Name}
                TextColor3={Color3.fromRGB(255, 208, 80)}
                TextScaled={true}
                ZIndex={0}
            />
            {this.props.Avatar}
        </textbutton>
    }
}