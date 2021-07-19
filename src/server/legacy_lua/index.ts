import { Handler } from "shared/handler";
import { OnJoinHandler } from "./onjoin/init";
import { SellingHandler } from "./selling/init";

export class LegacyLuaHandler extends Handler {
    run() {
        OnJoinHandler.run();
        SellingHandler.run();
    }
}