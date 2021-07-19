import { Handler } from "shared/handler";
import { AgeHandler } from "./age";
import { FactionsHandler } from "./factions";
import { FactionGeneratorHandler } from "./faction_generator";
import { LegacyLuaHandler } from "./legacy_lua";
import { SafezonesHandler } from "./safezones/safezones";
import { SpawnHandler } from "./spawn";

const ageHandler = new AgeHandler();
const factionGeneratorHandler = new FactionGeneratorHandler();
const factionHandler = new FactionsHandler();
const safezonesHandler = new SafezonesHandler();
const spawnHandler = new SpawnHandler();
const legacyLuaHandler = new LegacyLuaHandler();

async function run(handler: Handler) {
    try {
        handler.run();
    } catch (error) {
        warn(`Failed to load handler "${handler.name}" with error "${error}".`);
    }
}

run(ageHandler);
run(factionGeneratorHandler);
run(factionHandler);
run(safezonesHandler);
run(spawnHandler);
run(legacyLuaHandler);