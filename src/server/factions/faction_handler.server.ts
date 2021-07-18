import { quitCaching, startCaching } from ".";

startCaching();
game.BindToClose(() => quitCaching());