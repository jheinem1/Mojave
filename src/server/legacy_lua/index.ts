import { Handler } from "shared/handler";
import { OnJoinHandler } from "./onjoin/init";
import { SellingHandler } from "./selling/init";

/**
 * Runs legacy lua code such as nametags and a fix for the selling script
 */
export class LegacyLuaHandler extends Handler {
    name = "Legacy Lua";
    run() {
        OnJoinHandler.run();
        SellingHandler.run();
    }
}