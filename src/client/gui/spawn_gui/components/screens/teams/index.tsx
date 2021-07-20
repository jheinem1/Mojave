import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { Players, Workspace } from "@rbxts/services";
import { ClientFaction, getClientFactionInfo } from "client/factions";
import { Screen } from "../screen";
import { AvatarViewportComponent } from "./avatar_viewport";
import { TeamButtonComponent } from "./teambutton";

// const buttons = new Array<Roact.Element>();
// for (let i = 0; i < 3; i++)
//     buttons.push(<TeamButtonComponent
//         Name={tostring(i)}
//         Avatar={<AvatarViewportComponent />}
//         StartSize={0.3}
//         SelectedEvent={new ObjectEvent<[number]>()}
//         DeselectedEvent={new ObjectEvent<[number]>()}
//     />)

interface TeamsProps {
    currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>;
    selectedTeam: ObjectEvent<[number]>;
}

interface TeamsState {
    factions: ClientFaction[] | undefined;
}

class TeamsComponent extends Roact.Component<TeamsProps, TeamsState> {
    event = new ObjectEvent<[TeamButtonComponent, boolean]>();
    teamSelectedEvent = new ObjectEvent<[number]>();
    constructor(props: TeamsProps) {
        super(props);
        getClientFactionInfo().then(factionInfo => {
            this.setState({ factions: factionInfo });
            this.teamSelectedEvent.Connect(id => {
                this.props.selectedTeam.Fire(id);
                this.props.currentScreen[1](this.props.currentScreen[0].getValue() + 1);
            });
        });
        Workspace.CurrentCamera?.GetPropertyChangedSignal("ViewportSize").Connect(() => this.render());
    }
    render() {
        const teams = new Array<Roact.Element>();
        const numFactions = (this.state.factions?.size() ?? 0) + 1;
        this.state.factions?.forEach(faction => {
            teams.push(<TeamButtonComponent
                Name={faction.shortName}
                Id={faction.groupId}
                Avatar={<AvatarViewportComponent
                    player={Players.LocalPlayer}
                    shirtId={faction.uniformTop}
                    pantsId={faction.uniformBottom}
                />}
                NumButtons={numFactions}
                StartSelectedIfAlone={false}
                SelectedEvent={this.event}
                SelectionFinishedEvent={this.teamSelectedEvent}
            />)
        });
        return <frame
            Key="Teams"
            BackgroundColor3={Color3.fromRGB(255, 255, 255)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            <uilistlayout FillDirection={Enum.FillDirection.Horizontal} SortOrder={Enum.SortOrder.LayoutOrder} />
            <TeamButtonComponent
                Name={"WASTELANDER"}
                Id={-1}
                Avatar={<AvatarViewportComponent
                    player={Players.LocalPlayer}
                    shirtId={333020740}
                    pantsId={333020646}
                />}
                NumButtons={numFactions}
                StartSelectedIfAlone={true}
                SelectedEvent={this.event}
                SelectionFinishedEvent={this.teamSelectedEvent}
            />
            {teams}
        </frame>
    }
}

export class TeamsScreen extends Screen {
    name = "Teams";
    selectedTeam = -1;
    getScreenComponent(): Roact.Element {
        const selectedTeamEvent = new ObjectEvent<[number]>();
        selectedTeamEvent.Connect(id => this.selectedTeam = id);
        return <TeamsComponent
            currentScreen={this.currentScreen}
            selectedTeam={selectedTeamEvent}
        />;
    }
}