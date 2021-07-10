export interface PointMetadata {
    name: string;
    position: Vector3;
    canSpawn?: boolean
}

export class Point {
    constructor(public metatdata: PointMetadata) { }
}