import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { Workspace } from "@rbxts/services";

interface TeamButtonProps {
    Name: string;
    Id: number;
    Avatar: Roact.Element;
    NumButtons: number;
    SelectedEvent: ObjectEvent<[TeamButtonComponent, boolean]>;
    StartSelectedIfAlone: boolean
    SelectionFinishedEvent: ObjectEvent<[number]>;
    Event?: {
        TeamSelected?: (name: string) => void;
    }
}

interface TeamButtonState {
    selected: boolean;
    oneSelected: boolean;
}

export class TeamButtonComponent extends Roact.Component<TeamButtonProps, TeamButtonState> {
    constructor(props: TeamButtonProps) {
        super(props);
        props.SelectedEvent.Connect((element, selected) => this.setState({
            selected: element === this ? selected : false,
            oneSelected: selected
        }));
        if (props.StartSelectedIfAlone)
            this.setState({
                selected: props.StartSelectedIfAlone,
                oneSelected: props.StartSelectedIfAlone
            });
        else
            props.SelectedEvent.Fire(this, false);
    }
    render() {
        const normalMinimizedSize = Workspace.CurrentCamera ? math.ceil(Workspace.CurrentCamera.ViewportSize.X / this.props.NumButtons) : 0;
        const selectedMinimizedSize = Workspace.CurrentCamera ? math.ceil(Workspace.CurrentCamera.ViewportSize.X / (this.props.NumButtons + 0.5)) : 0;
        const maximizedSize = math.ceil(selectedMinimizedSize * 1.5);
        return <textbutton
            Key={this.props.Name}
            BackgroundColor3={this.state.selected ? Color3.fromRGB(46, 46, 46) : Color3.fromRGB(23, 23, 23)}
            BorderSizePixel={0}
            ClipsDescendants={true}
            Size={new UDim2(0, this.state.selected ? maximizedSize : this.state.oneSelected ? selectedMinimizedSize : normalMinimizedSize, 1, 0)}
            Text=""
            AutoButtonColor={false}
            Event={{
                MouseButton1Click: () => {
                    if (this.state.selected)
                        this.props.SelectionFinishedEvent.Fire(this.props.Id);
                    else
                        this.props.SelectedEvent.Fire(this, true);
                }
            }}
        >
            <textlabel
                Key="Faction"
                BackgroundTransparency={1}
                Size={new UDim2(1, 0, 0.25, 0)}
                Visible={this.state.selected || this.state.oneSelected ? selectedMinimizedSize >= 350 : normalMinimizedSize >= 350}
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