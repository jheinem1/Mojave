import { t } from "@rbxts/t";
import { Point } from "./point";

const getValidPointConstructors = (pointConstructors: Instance[]) => pointConstructors.map(t.children({
    Name: t.instanceIsA("StringValue"),
    Position: t.instanceIsA("Vector3Value"),
    CanSpawn: t.union(t.instanceIsA("BoolValue"), t.none)
}));

export function genPoints(pointConstructors: Model[]) {
    const validPointConstructors = getValidPointConstructors(pointConstructors);
    
}

export function mapBounds(points: Point[]) { }