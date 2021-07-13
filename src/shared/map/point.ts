export interface PointMetadata {
    name: string;
    position: Vector2;
    canSpawn?: boolean
}

export class Point {
    constructor(public readonly position: Vector2, public readonly name: string, public readonly canSpawn: boolean = false) { }
}