export interface PointMetadata {
    name: string;
    position: Vector3;
    canSpawn?: boolean
}

export class Point {
    x: number;
    y: number;
    constructor(protected metatdata: PointMetadata) {
        this.x = metatdata.position.X;
        this.y = metatdata.position.Y
    }
}