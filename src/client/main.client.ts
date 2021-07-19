import { run } from "shared/handler";
import { GuiHandler } from "./gui";
import { SafezonesHandler } from "./safezones/safezones";

const guiHandler = new GuiHandler();
const safezones = new SafezonesHandler();

run(guiHandler);
run(safezones);