import { Handler } from "shared/handler";
import { generateTeams } from "./generator_funcs";

export class TeamGeneratorHandler extends Handler {
    name = "TeamGenerator";
    run() {
        generateTeams();
    }
}