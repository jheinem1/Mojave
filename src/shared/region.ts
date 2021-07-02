import { RunService } from "@rbxts/services";
import { t } from "@rbxts/t";

const isCharacter = t.union(t.instanceIsA("Model"), t.children({
    HumanoidRootPart: t.instanceIsA("Part"),
    Humanoid: t.instanceIsA("Humanoid"),
    Head: t.instanceOf("BasePart")
}));

type Character = Model & {
    HumanoidRootPart: Part,
    Humanoid: Humanoid,
    Head: BasePart
}

abstract class Region {
    /**
     * Gets the HumanoidRootPart of a player or character, throws an error if invalid character
     */
    protected getRoot(object: Player | Model): Part {
        if (t.instanceIsA("Player")(object))
            return object.Character ? this.getRoot(object.Character) : this.getRoot(object.CharacterAdded.Wait()[0]);
        else if (isCharacter(object))
            return (object as Character).HumanoidRootPart;
        else
            throw "Invalid character model!"
    }
    /**
     * @param object A valid player or character, will throw error if missing properties
     * @returns A promise that resolves when a player enters the region
     */
    abstract enteredRegion(object: Player | Model): Promise<void>;
    /**
     * @param object A valid player or character, will throw error if missing properties
     * @returns A promise that resolves when a player leaves the region
     */
    abstract leftRegion(object: Player | Model): Promise<void>;
    /**
     * Checks if the player/character is inside the region.
     * @param object A valid player or character, will throw error if missing properties.
     * @returns True if the player is in the region, false if not
     */
    abstract isInRegion(object: Player | Model): boolean;
}


/**
 * Rectangular regions are a great way to define event-based areas using Roblox's own physics engine
 */
export class BasePartRegion extends Region {
    protected part: Part;
    constructor(part: BasePart) {
        super();
        const newPart = new Instance("Part");
        newPart.Position = part.Position;
        newPart.Size = part.Size;
        newPart.Anchored = true;
        newPart.Transparency = 1;
        newPart.CanCollide = false;
        this.part = newPart;
    }
    async enteredRegion(object: Model | Player): Promise<void> {
        const root = this.getRoot(object);
        if (root.GetTouchingParts().some(part => part === this.part))
            return;
        return new Promise(resolve => {
            let connection: RBXScriptConnection
            connection = this.part.Touched.Connect(hit => {
                if (hit === root) {
                    connection.Disconnect();
                    resolve();
                }
            });
        });
    }
    async leftRegion(object: Model | Player): Promise<void> {
        const root = this.getRoot(object);
        if (root.GetTouchingParts().some(part => part === this.part))
            return;
        return new Promise(resolve => {
            let connection: RBXScriptConnection
            connection = this.part.TouchEnded.Connect(hit => {
                if (hit === root) {
                    connection.Disconnect();
                    resolve();
                }
            });
        });
    }
    isInRegion(object: Model | Player): boolean {
        return this.getRoot(object).GetTouchingParts().some(part => part === this.part);
    }
}

/**
 * Spherical regions offer a much faster alternative to rectangular regions, as simple distance checks are much faster
 */
export class SphereRegion extends Region {
    protected center: Vector3;
    protected radius: number;
    constructor(sphere: Part) {
        super();
        this.center = sphere.Position;
        this.radius = math.min(sphere.Size.X, sphere.Size.Y, sphere.Size.Z);
    }
    async enteredRegion(object: Model | Player): Promise<void> {
        const root = this.getRoot(object);
        return new Promise(resolve => {
            let connection: RBXScriptConnection
            connection = RunService.Heartbeat.Connect(() => {
                if ((root.Position.sub(this.center)).Magnitude <= this.radius) {
                    RunService.UnbindFromRenderStep(tostring(this));
                    resolve();
                }
            });
        });
    }
    async leftRegion(object: Model | Player): Promise<void> {
        const root = this.getRoot(object);
        return new Promise(resolve => {
            let connection: RBXScriptConnection
            connection = RunService.Heartbeat.Connect(() => {
                if ((root.Position.sub(this.center)).Magnitude > this.radius) {
                    RunService.UnbindFromRenderStep(tostring(this));
                    resolve();
                }
            });
        });
    }
    isInRegion(object: Model | Player): boolean {
        return (this.getRoot(object).Position.sub(this.center)).Magnitude <= this.radius;
    }
    /**
     * @param object A valid player or character, will throw error if missing properties.
     * @returns The character's distance from the center
     */
    getDistance(object: Model | Player): number {
        return (this.getRoot(object).Position.sub(this.center)).Magnitude
    }
}

/**
 * A handy way to group regions of any type
 */
export class RegionUnion {
    constructor(public regions: Region[]) { }
    /**
     * @param object A valid player or character, will throw error if missing properties
     * @returns A promise that resolves when a player enters a region
     */
    async enteredRegion(object: Player | Model) {
        return Promise.race(this.regions.map(region => region.enteredRegion(object)));
    }
    /**
     * @param object A valid player or character, will throw error if missing properties
     * @returns A promise that resolves when a player leaves a region
     */
    async leftRegion(object: Player | Model) {
        return Promise.race(this.regions.map(region => region.leftRegion(object)));
    }
    /**
     * Checks if the player/character is inside all regions.
     * @param object A valid player or character, will throw error if missing properties
     * @returns An array of regions (if any) the player is in
     */
    isInRegions(object: Player | Model): Region[] {
        return this.regions.filter(region => region.isInRegion(object));
    }
    /**
     * Checks if the player/character is inside a single region.
     * @param object A valid player or character, will throw error if missing properties
     * @returns A region (if any) the player is in
     */
    isInRegion(object: Player | Model): Region | undefined {
        return this.regions.find(region => region.isInRegion(object));
    }
}