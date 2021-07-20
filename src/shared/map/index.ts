import { Point } from "./point";
import { mapBounds } from "./point_gen";

/** used for holding all points in a game- generally for spawn locations */
export class GameMap {
    public size: Vector2;
    constructor(public points: Point[]) {
        points = points.map(absPoint => Point.fromPoint(absPoint, new Vector2(absPoint.position.Y, -absPoint.position.X)));
        const [lower, upper] = mapBounds(this.points);
        this.size = upper.sub(lower);
        this.points = points.map(absPoint => Point.fromPoint(absPoint, absPoint.position.sub(lower)));
    }
}