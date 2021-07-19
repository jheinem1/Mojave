import { AgeHandler } from "./age";
import { FactionHandler } from "./factions";
import { FactionGeneratorHandler } from "./faction_generator";
import { LegacyLuaHandler } from "./legacy_lua";
import { SafezonesHandler } from "./safezones/safezones";
import { SpawnHandler } from "./spawn";

const ageHandler = new AgeHandler();
const factionGeneratorHandler = new FactionGeneratorHandler();
const factionHandler = new FactionHandler();
const safezonesHandler = new SafezonesHandler();
const spawnHandler = new SpawnHandler();
const legacyLuaHandler = new LegacyLuaHandler();

ageHandler.run();
factionGeneratorHandler.run();
factionHandler.run();
safezonesHandler.run();
spawnHandler.run();
legacyLuaHandler.run();