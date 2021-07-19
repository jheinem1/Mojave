import { t } from "@rbxts/t";
import { Point } from "./point";

type PointConstructor = Instance & {
    PointName: StringValue;
    Position: Instance & {
        X: NumberValue;
        Y: NumberValue;
    }
    CanSpawn: BoolValue;
    Safezone: BoolValue;
    CapturePointStatus: NumberValue;
}
const isValidPointConstructor = t.children({
    PointName: t.instanceIsA("StringValue"),
    Position: t.children({
        X: t.instanceIsA("NumberValue"),
        Y: t.instanceIsA("NumberValue")
    }),
    CanSpawn: t.instanceIsA("BoolValue"),
    Safezone: t.instanceIsA("BoolValue")
})
const getValidPointConstructors = (pointConstructors: Instance[]) => pointConstructors.mapFiltered(
    pointConstructor => isValidPointConstructor(pointConstructor) ? <PointConstructor>pointConstructor : undefined
);

/** generates an array of `Point` objects from an array of valid `PointConstructor` instances (see PointConsturctor type) */
export function genPoints(pointConstructors: Instance[]) {
    return getValidPointConstructors(pointConstructors).map((pointConstructor) => new Point(
        new Vector2(pointConstructor.Position.X.Value, pointConstructor.Position.X.Value),
        pointConstructor.PointName.Value,
        pointConstructor.CanSpawn.Value,
        pointConstructor.Safezone.Value,
        pointConstructor.CapturePointStatus)
    );
}

/** determines the bounds of a map from an array of `Point` objects and returns a tuple of the upper and lower bounds */
export function mapBounds(points: Point[]): [Vector2, Vector2] {
    return [new Vector2(
        points.reduce((lowest, current) => current.position.X < lowest.position.X ? current : lowest).position.X,
        points.reduce((lowest, current) => current.position.Y < lowest.position.Y ? current : lowest).position.Y
    ), new Vector2(
        points.reduce((highest, current) => current.position.X > highest.position.X ? current : highest).position.X,
        points.reduce((highest, current) => current.position.Y > highest.position.Y ? current : highest).position.Y
    )];
}