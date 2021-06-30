import ObjectEvent from "@rbxts/object-event";
import Roact from "@rbxts/roact";
import { getClientFactionInfo } from "shared/faction_manager";
import { ProgressItemComponent } from "../progress_item";
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

class TeamsComponent extends Roact.Component {
    factions = getClientFactionInfo();
    render() {
        return <frame
            Key="Teams"
            BackgroundColor3={Color3.fromRGB(255, 255, 255)}
            BorderSizePixel={0}
            Position={new UDim2(0, 0, 0, 36)}
            Size={new UDim2(1, 0, 1, -36)}
        >
            <uilistlayout FillDirection={Enum.FillDirection.Horizontal} SortOrder={Enum.SortOrder.LayoutOrder} />
            { }
        </frame>
    }
}

export class TeamsScreen extends Screen {
    name = "Teams";
    getScreenComponent(): Roact.Element {
        return <TeamsComponent />;
    }
}