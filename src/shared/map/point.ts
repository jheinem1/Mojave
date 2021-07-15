export interface PointMetadata {
    name: string;
    position: Vector2;
    canSpawn?: boolean
}

/** a 2d point in the game- generally used for spawn locations */
export class Point {
    constructor(public readonly position: Vector2, public readonly name: string, public readonly canSpawn: boolean, public readonly safezone: boolean) { }
}