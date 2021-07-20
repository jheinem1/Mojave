import { Point } from "./point";
import { mapBounds } from "./point_gen";

/** used for holding all points in a game- generally for spawn locations */
export class GameMap {
    public size: Vector2;
    constructor(public points: Point[]) {
        points = points.map(absPoint => Point.fromPoint(absPoint, new Vector2(absPoint.position.X, absPoint.position.Y)));
        const [lower, upper] = mapBounds(points);
        this.points = points.map(absPoint => Point.fromPoint(absPoint, absPoint.position.sub(lower)));
        this.size = upper.sub(lower);
    }
}