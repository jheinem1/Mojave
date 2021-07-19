import { AgeHandler } from "./age";
import { FactionHandler } from "./factions";
import { FactionGeneratorHandler } from "./faction_generator";
import { SafezonesHandler } from "./safezones/safezones.server";
import { SpawnHandler } from "./spawn";

const ageHandler = new AgeHandler();
const factionGeneratorHandler = new FactionGeneratorHandler();
const factionHandler = new FactionHandler();
const safezonesHandler = new SafezonesHandler();
const spawnHandler = new SpawnHandler();

ageHandler.run();
factionGeneratorHandler.run();
factionHandler.run();
safezonesHandler.run();
spawnHandler.run();