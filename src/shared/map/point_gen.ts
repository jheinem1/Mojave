import { t } from "@rbxts/t";
import { Point } from "./point";

type PointConstructor = Model & {
    PointName: StringValue;
    PositionX: NumberValue;
    PositionY: NumberValue;
    CanSpawn?: BoolValue;
}
const isValidPointConstructor = t.children({
    PointName: t.instanceIsA("StringValue"),
    PositionX: t.instanceIsA("NumberValue"),
    PositionY: t.instanceIsA("NumberValue"),
    CanSpawn: t.union(t.instanceIsA("BoolValue"), t.none)
})
const getValidPointConstructors = (pointConstructors: Instance[]) => pointConstructors.mapFiltered(
    pointConstructor => isValidPointConstructor(pointConstructor) ? <PointConstructor>pointConstructor : undefined
);

export function genPoints(pointConstructors: Model[]) {
    return getValidPointConstructors(pointConstructors).map((pointConstructor) => new Point(
        new Vector2(pointConstructor.PositionX.Value, pointConstructor.PositionY.Value),
        pointConstructor.PointName.Value,
        pointConstructor.CanSpawn?.Value));
}

export function mapBounds(points: Point[]): [Vector2, Vector2] {
    return [new Vector2(
        points.reduce((lowest, current) => current.position.X < lowest.position.X ? current : lowest).position.X,
        points.reduce((lowest, current) => current.position.Y < lowest.position.Y ? current : lowest).position.Y
    ), new Vector2(
        points.reduce((highest, current) => current.position.X > highest.position.X ? current : highest).position.X,
        points.reduce((highest, current) => current.position.Y > highest.position.Y ? current : highest).position.Y
    )];
}