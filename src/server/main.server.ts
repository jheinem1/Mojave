import { run } from "shared/handler";
import { AgeHandler } from "./age";
import { FactionsHandler } from "./factions";
import { FactionGeneratorHandler } from "./faction_generator";
import { LegacyLuaHandler } from "./legacy_lua";
import { SafezonesHandler } from "./safezones/safezones";
import { SpawnHandler } from "./spawn";
import { TeamGeneratorHandler } from "./team_generator";

const factionHandler = new FactionsHandler();
const teamGeneratorHandler = new TeamGeneratorHandler();
const factionGeneratorHandler = new FactionGeneratorHandler();
const ageHandler = new AgeHandler();
const safezonesHandler = new SafezonesHandler();
const spawnHandler = new SpawnHandler();
const legacyLuaHandler = new LegacyLuaHandler();

run(factionHandler);
run(teamGeneratorHandler);
run(factionGeneratorHandler);
run(ageHandler);
run(safezonesHandler);
run(spawnHandler);
run(legacyLuaHandler);