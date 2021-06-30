import ObjectEvent from "@rbxts/object-event";
import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";

abstract class BaseRegion {
    protected parts = new Array<BasePart>();
    protected regions: RotatedRegion3[]; // = new Array<RotatedRegion3>();
    protected disabled = false;
    enteredRegion = new ObjectEvent<[Player, BasePart | undefined]>();
    leftRegion = new ObjectEvent<[Player, BasePart | undefined]>();

    constructor(regions: BasePart[] | RotatedRegion3[]) {
        if (t.instanceIsA("BasePart")(regions[0]))
            this.regions = regions.map((part: BasePart | RotatedRegion3) => {
                this.parts.push(part as BasePart);
                return RotatedRegion3.FromPart(part as BasePart);
            });
        else this.regions = regions as RotatedRegion3[];
    }

    /**
     * Must call this method before garbage collection to prevent memory leaks
     */
    kill() {
        this.disabled = true;
    }

    abstract isInRegion(player: Player): boolean;
}

export class GlobalRegions extends BaseRegion {
    constructor(parts: BasePart[] | RotatedRegion3[]) {
        super(parts);
        this.regionCheck(this.enteredRegion, this.leftRegion, this.regions);
    }

    protected async regionCheck(
        enteredRegion: ObjectEvent<[Player, BasePart | undefined]>,
        leftRegion: ObjectEvent<[Player, BasePart | undefined]>,
        regions: RotatedRegion3[]
    ) {
        let connection: RBXScriptConnection;
        let inRegion = new WeakMap<Player, RotatedRegion3>();
        const check = () => {
            if (!this.disabled) {
                Players.GetPlayers().forEach((player) => {
                    const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
                    let index = -1;
                    if (
                        t.instanceIsA("BasePart")(rootPart) &&
                        regions.some((region, i) => {
                            index = i;
                            return region.CastPart(rootPart);
                        })
                    ) {
                        if (inRegion.get(player) !== regions[index]) {
                            inRegion.set(player, regions[index]);
                            enteredRegion.Fire(player, this.parts[index]);
                        }
                    } else if (inRegion.get(player)) {
                        inRegion.delete(player);
                        leftRegion.Fire(player, this.parts[index]);
                    }
                });
            } else connection.Disconnect();
        };
        connection = RunService.Heartbeat.Connect(() => check());
        check();
    }

    isInRegion(player: Player) {
        const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
        if (
            t.instanceIsA("BasePart")(rootPart) &&
            super.regions.some((region) => region.CastPart(rootPart))
        )
            return true;
        return false;
    }
}

export class ClientRegions extends BaseRegion {
    protected client: Player;
    protected currentRegion: RotatedRegion3 | unknown;

    constructor(
        parts: BasePart[] | RotatedRegion3[],
        client = Players.LocalPlayer
    ) {
        super(parts);
        assert(client, "Client argument must be provided on the server");
        this.client = client;
        this.regionCheck(this.enteredRegion, this.leftRegion, this.regions, client);
    }

    protected async regionCheck(
        enteredRegion: ObjectEvent<[Player, BasePart | undefined]>,
        leftRegion: ObjectEvent<[Player, BasePart | undefined]>,
        regions: RotatedRegion3[],
        client: Player
    ) {
        let connection: RBXScriptConnection;
        let inRegion = false;
        const check = () => {
            if (!this.disabled) {
                const rootPart = client.Character?.FindFirstChild("HumanoidRootPart");
                let index = -1;
                if (
                    t.instanceIsA("BasePart")(rootPart) &&
                    regions.some((region, i) => {
                        index = i;
                        return region.CastPart(rootPart);
                    })
                ) {
                    if (this.currentRegion !== regions[index]) {
                        inRegion = true;
                        this.currentRegion = regions[index];
                        enteredRegion.Fire(client, this.parts[index]);
                    }
                } else if (inRegion) {
                    inRegion = false;
                    this.currentRegion = undefined;
                    leftRegion.Fire(client, this.parts[index]);
                }
            } else connection.Disconnect();
        };
        connection = RunService.Heartbeat.Connect(() => check());
        check();
    }

    isInRegion() {
        const rootPart = this.client.Character?.FindFirstChild("HumanoidRootPart");
        if (
            t.instanceIsA("BasePart")(rootPart) &&
            this.regions.some((region) => region.CastPart(rootPart))
        )
            return true;
        return false;
    }
}
