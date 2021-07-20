export interface PointMetadata {
    name: string;
    position: Vector2;
    canSpawn?: boolean
}

/** a 2d point in the game- generally used for spawn locations */
export class Point {
    canSpawn: boolean;
    controllingFaction = -1;
    constructor(public readonly position: Vector2, public readonly name: string, public readonly safezone: boolean, public readonly capturePointStatus: NumberValue, public readonly spawnPoints?: Vector3[]) {
        this.controllingFaction = capturePointStatus.Value;
        capturePointStatus.Changed.Connect(id => this.controllingFaction = id);
        this.canSpawn = spawnPoints ? spawnPoints.size() > 0 : false;
    }
    /**
     * Alternative constructor for creating a point using an existing point (makes all arguments optional)
     */
    static fromPoint(point: Point, position?: Vector2, name?: string, safezone?: boolean, capturePointStats?: NumberValue, spawnPoints?: Vector3[]) {
        return new Point(
            position ?? point.position,
            name ?? point.name,
            safezone ?? point.safezone,
            capturePointStats ?? point.capturePointStatus,
            spawnPoints ?? point.spawnPoints
        );
    }
}