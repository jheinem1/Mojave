import { GuiHandler } from "./gui";
import { SafezonesHandler } from "./safezones/safezones";

const guiHandler = new GuiHandler();
const safezones = new SafezonesHandler();

guiHandler.run();
safezones.run();