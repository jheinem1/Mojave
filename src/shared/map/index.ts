import { Point } from "./point";


export class GameMap {
    public size: Vector2;
    constructor(public points: Point[], public bounds: [Vector2, Vector2]) {
        this.size = bounds[1].sub(bounds[0]);
        this.points = points.map(absPoint => new Point(absPoint.position.sub(bounds[0]), absPoint.name, absPoint.canSpawn));
    }
}