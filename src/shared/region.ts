import RotatedRegion3 from "@rbxts/rotatedregion3";
import { RunService, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";

abstract class Region {
    /**
     * @returns A promise that resolves when a player enters the region
     */
    abstract enteredRegion(part: BasePart): Promise<void>;
    /**
     * @returns A promise that resolves when a player leaves the region
     */
    abstract leftRegion(part: BasePart): Promise<void>;
    /**
     * Checks if the player/character is inside the region.
     * @returns True if the player is in the region, false if not
     */
    abstract isInRegion(part: BasePart): boolean;
}


/**
 * Rectangular regions are a great way to define event-based areas using Roblox's own physics engine
 */
export class BasePartRegion extends Region {
    protected part: Part;
    protected rotatedRegion3: RotatedRegion3;
    constructor(part: BasePart) {
        super();
        const newPart = new Instance("Part");
        newPart.CFrame = part.CFrame;
        newPart.Size = part.Size;
        newPart.Shape = t.instanceIsA("Part")(part) ? part.Shape : Enum.PartType.Block;
        newPart.Anchored = true;
        newPart.Transparency = 1;
        newPart.CanCollide = false;
        newPart.CanTouch = true;
        newPart.Parent = RunService.IsClient() ? Workspace : undefined;
        newPart.Name = tostring(this);
        this.part = newPart;
        this.rotatedRegion3 = RotatedRegion3.FromPart(this.part);
    }
    async enteredRegion(part: BasePart) {
        if (RunService.IsClient()) {
            let inRegion = this.isInRegion(part);
            while (!inRegion)
                inRegion = part.Touched.Wait()[0] === this.part;
        } else
            while (this.isInRegion(part))
                wait(0.1);

    }
    async leftRegion(part: BasePart) {
        if (RunService.IsClient()) {
            let inRegion = this.isInRegion(part);
            while (inRegion)
                inRegion = !(part.TouchEnded.Wait()[0] === this.part);
        } else
            while (this.isInRegion(part))
                wait(0.1);
    }
    isInRegion(part: BasePart) {
        return this.rotatedRegion3.CastPoint(part.Position);
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
    async enteredRegion(part: BasePart) {
        while (!this.isInRegion(part))
            wait(0.1);
    }
    async leftRegion(part: BasePart) {
        while (this.isInRegion(part))
            wait(0.1);
    }
    isInRegion(part: BasePart) {
        return (part.Position.sub(this.center)).Magnitude <= this.radius;
    }
    /**
     * @returns The character's distance from the center
     */
    getDistance(part: BasePart) {
        return (part.Position.sub(this.center)).Magnitude;
    }
}

/**
 * A handy way to group regions of any type
 */
export class RegionUnion {
    constructor(public regions: Region[]) { }
    /**
     * @returns A promise that resolves when a player enters a region
     */
    async enteredRegion(part: BasePart) {
        return Promise.race(this.regions.map(region => region.enteredRegion(part)));
    }
    /**
     * @returns A promise that resolves when a player leaves a region
     */
    async leftRegion(part: BasePart) {
        return Promise.all(this.regions.map(region => region.leftRegion(part)));
    }
    /**
     * Checks if the player/character is inside all regions.
     * @returns An array of regions (if any) the player is in
     */
    isInRegions(part: BasePart) {
        return this.regions.filter(region => region.isInRegion(part));
    }
    /**
     * Checks if the player/character is inside a single region.
     * @returns A region (if any) the player is in
     */
    isInRegion(part: BasePart) {
        return this.regions.find(region => region.isInRegion(part));
    }
}