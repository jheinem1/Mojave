import Roact from "@rbxts/roact";
import { ActionPoints } from "./ap";
import { Caps } from "./caps";
import { Compass } from "./compass";
import { Health } from "./health";
import { Scope } from "./scope";
import { Settings } from "./settings";
import { State } from "./state";
import { Tool } from "./tool";

export class HudComponent extends Roact.Component {
    render() {
        return <screengui Key="HUD" ResetOnSpawn={false}>
            <Health />
            <Tool />
            <ActionPoints />
            <State />
            <Compass />
            <Scope />
            <Settings />
            <Caps />
        </screengui>
    }
}