import { Handler } from "shared/handler";
import { quitCaching, startCaching } from "./faction";

/**
 * Caches faction information for client remotes and such
 */
export class FactionsHandler extends Handler {
    name = "Factions";
    run() {
        startCaching();
        game.BindToClose(() => quitCaching());
    }
}