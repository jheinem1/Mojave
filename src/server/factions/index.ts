import { Handler } from "shared/handler";
import { quitCaching, startCaching } from "./faction";

export class FactionHandler extends Handler {
    run() {
        startCaching();
        game.BindToClose(() => quitCaching());
    }
}