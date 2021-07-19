import ObjectEvent from "@rbxts/object-event";
import Roact, { } from "@rbxts/roact";
import { Players } from "@rbxts/services";
import { getClientFactionInfo } from "client/factions";
import { Point } from "shared/map/point";
import SpawnRemotes from "shared/spawn/remotes";
import { MapScreen } from "./screens/map";
import { Screen } from "./screens/screen";
import { TeamsScreen } from "./screens/teams";

interface ProgressProps {
    currentScreen: LuaTuple<[Roact.Binding<number>, (newValue: number) => void]>;
    finished: ObjectEvent<[]>;
}

export class ProgressComponent extends Roact.Component<ProgressProps, {}> {
    screens: [TeamsScreen, MapScreen];
    constructor(props: ProgressProps) {
        super(props);
        const valueChange = props.currentScreen[1];
        props.currentScreen[1] = newValue => {
            valueChange(newValue);
            this.setState({});
        };
        this.screens = [
            new TeamsScreen(0, props.currentScreen),
            new MapScreen(1, props.currentScreen, point => this.onSpawn(point))
        ];

    }
    async onSpawn(point: Point) {
        const selectedTeamId = this.screens[0].selectedTeam;
        print(`${Players.LocalPlayer} has selected to spawn as ${await (await getClientFactionInfo()).find(faction => faction.groupId === selectedTeamId) ?? "Wastelanders"} in ${point.name}`);
        const remote = await SpawnRemotes.Client.Get("RequestSpawn");
        remote.CallServerAsync({
            pointName: point.name,
            faction: selectedTeamId
        }).then(([success, errorMsg]) => {
            if (success)
                this.props.finished.Fire()
            else
                warn(errorMsg);
        })
    }
    render() {
        const items = [<uilistlayout
            FillDirection={Enum.FillDirection.Horizontal}
            HorizontalAlignment={Enum.HorizontalAlignment.Center}
            Padding={new UDim(0.1, 0)}
            SortOrder={Enum.SortOrder.LayoutOrder}
        />]
        this.screens.forEach(screen => items.push(screen.getButtonComponent()));
        return <frame BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
            {Roact.createElement("Frame", {
                Name: "List",
                BackgroundTransparency: 1,
                Position: new UDim2(0.3, 70, 0, 0),
                Size: new UDim2(0.7, -70, 0, 36)
            }, items)}
            {this.screens[this.props.currentScreen[0].getValue()].getScreenComponent()}
        </frame>;
    }
}