import Net from "@rbxts/net";
import { SpawnArgs } from "./data_structures";

const SpawnRemotes = Net.Definitions.Create({
    RequestSpawn: Net.Definitions.ServerAsyncFunction<(spawnArgs: SpawnArgs) => [boolean, string?]>()
});
export default SpawnRemotes;