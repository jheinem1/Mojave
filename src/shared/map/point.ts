export interface PointMetadata {
    name: string;
    position: Vector2;
    canSpawn?: boolean
}

/** a 2d point in the game- generally used for spawn locations */
export class Point {
    controllingFaction = -1;
    constructor(public readonly position: Vector2, public readonly name: string, public readonly canSpawn: boolean, public readonly safezone: boolean, public readonly capturePointStatus: NumberValue) {
        capturePointStatus.Changed.Connect(id => this.controllingFaction = id);
    }
    /**
     * Alternative constructor for creating a point using an existing point (makes all arguments optional)
     */
    static fromPoint(point: Point, position?: Vector2, name?: string, canSpawn?: boolean, safezone?: boolean, capturePointStats?: NumberValue) {
        return new Point(
            position ?? point.position,
            name ?? point.name,
            canSpawn ?? point.canSpawn,
            safezone ?? point.safezone,
            capturePointStats ?? point.capturePointStatus
        );
    }
}