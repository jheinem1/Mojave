import { quitCaching, startCaching } from "shared/faction_manager";

startCaching();
game.BindToClose(() => quitCaching());