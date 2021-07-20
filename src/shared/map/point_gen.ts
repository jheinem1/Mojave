import { t } from "@rbxts/t";
import { Point } from "./point";

type PointConstructor = Instance & {
    PointName: StringValue;
    Position: Instance & {
        X: NumberValue;
        Y: NumberValue;
    }
    Safezone: BoolValue;
    Spawns?: Instance & { [spawn: string]: Vector3Value };
    CapturePointStatus: NumberValue;
}
const isValidPointConstructor = t.children({
    PointName: t.instanceIsA("StringValue"),
    Position: t.children({
        X: t.instanceIsA("NumberValue"),
        Y: t.instanceIsA("NumberValue")
    }),
    Safezone: t.instanceIsA("BoolValue"),
    CapturePointStatus: t.instanceIsA("NumberValue")
})
const getValidPointConstructors = (pointConstructors: Instance[]) => pointConstructors.mapFiltered(
    pointConstructor => isValidPointConstructor(pointConstructor) ? <PointConstructor>pointConstructor : undefined
);
let cachedPoints: Array<Point> | undefined;

/** generates an array of `Point` objects from an array of valid `PointConstructor` instances (see PointConsturctor type) */
export function genPoints(pointConstructors: Instance[], update?: boolean) {
    return (cachedPoints && !update) ? cachedPoints : getValidPointConstructors(pointConstructors).map((pointConstructor) => {
        const spawns = pointConstructor.FindFirstChild("Spawns")?.GetChildren().mapFiltered(instance => t.instanceIsA("Vector3Value")(instance) ? instance.Value : undefined);
        return new Point(
            new Vector2(pointConstructor.Position.X.Value, pointConstructor.Position.Y.Value),
            pointConstructor.PointName.Value,
            pointConstructor.Safezone.Value,
            pointConstructor.CapturePointStatus,
            spawns
        );
    });
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