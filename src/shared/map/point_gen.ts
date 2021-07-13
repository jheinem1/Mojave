import { t } from "@rbxts/t";
import { Point } from "./point";

type PointConstructor = Model & {
    PointName: StringValue;
    Position: Vector3Value;
    CanSpawn?: BoolValue;
}
const isValidPointConstructor = t.children({
    PointName: t.instanceIsA("StringValue"),
    Position: t.instanceIsA("Vector3Value"),
    CanSpawn: t.union(t.instanceIsA("BoolValue"), t.none)
})
const getValidPointConstructors = (pointConstructors: Instance[]) => pointConstructors.mapFiltered(
    pointConstructor => isValidPointConstructor(pointConstructor) ? <PointConstructor>pointConstructor : undefined
);

export function genPoints(pointConstructors: Model[]) {
    return getValidPointConstructors(pointConstructors).map((pointConstructor) => new Point({
        name: pointConstructor.PointName.Value,
        position: pointConstructor.Position.Value,
        canSpawn: pointConstructor.CanSpawn?.Value
    }));
}

export function mapBounds(points: Point[]): [Vector2, Vector2] {
    return [new Vector2(
        points.reduce((lowest, current) => current.x < lowest.x ? current : lowest).x,
        points.reduce((lowest, current) => current.y < lowest.y ? current : lowest).y
    ), new Vector2(
        points.reduce((highest, current) => current.x > highest.x ? current : highest).x,
        points.reduce((highest, current) => current.y > highest.y ? current : highest).y
    )];
}