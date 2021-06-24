import Roact from "@rbxts/roact";
import { ActionPoints } from "./ap";
import { Caps } from "./caps";
import { Compass } from "./compass";
import { Health } from "./health";
import { Scope } from "./scope";
import { Settings } from "./settings";
import { State } from "./state";
import { ToolComponent } from "./tool";

export class HudComponent extends Roact.Component {
    render() {
        return <screengui Key="HUD" ResetOnSpawn={false}>
            <Health />
            <ToolComponent />
            <ActionPoints />
            <State />
            <Compass />
            <Scope />
            <Settings />
            <Caps />
        </screengui>
    }
}