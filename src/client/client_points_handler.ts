import { ReplicatedStorage, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { GameMap } from "shared/map";
import { genPoints, mapBounds } from "shared/map/point_gen";

const location = ReplicatedStorage.WaitForChild("Points", 5);
assert(t.instanceOf("Folder")(location), "Expected folder in the ReplicatedStorage named 'Points'");

const points = genPoints(location.GetChildren())
const bounds = mapBounds(points);
const gameMap = new GameMap(points, bounds);
export default gameMap;