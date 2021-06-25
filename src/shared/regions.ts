import ObjectEvent from "@rbxts/object-event";
import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";

abstract class BaseRegion {
    // protected parts = new Array<BasePart>();
    protected regions: RotatedRegion3[];// = new Array<RotatedRegion3>();
    // protected disabled = false;
    enteredRegion = new ObjectEvent<[Player]>();
    leftRegion = new ObjectEvent<[Player]>();

    constructor(regions: BasePart[] | RotatedRegion3[]) {
        // parts.forEach(part => {
        //     parts.push(part);
        //     this.regions.push(RotatedRegion3.FromPart(part));
        // });
        if (t.instanceIsA("BasePart")(regions[0]))
            this.regions = regions.map((part: BasePart | RotatedRegion3) => RotatedRegion3.FromPart(part as BasePart));
        else
            this.regions = regions as RotatedRegion3[];
    }

    abstract isInRegion(player: Player): boolean;
}

export class GlobalRegions extends BaseRegion {
    constructor(parts: BasePart[] | RotatedRegion3[]) {
        super(parts);
        this.regionCheck(this.enteredRegion, this.leftRegion, this.regions);
    }

    protected async regionCheck(enteredRegion: ObjectEvent<[Player]>, leftRegion: ObjectEvent<[Player]>, regions: RotatedRegion3[]) {
        let connection: RBXScriptConnection;
        let inRegion = new WeakMap<Player, boolean>();
        const weakRef = setmetatable({ this: this }, { __mode: "k" });
        const check = (weakRef: { this: GlobalRegions }) => {
            if (weakRef.this) {
                Players.GetPlayers().forEach(player => {
                    const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
                    if (t.instanceIsA("BasePart")(rootPart) && regions.some((region) => region.CastPart(rootPart))) {
                        if (!inRegion.get(player)) {
                            inRegion.set(player, true);
                            enteredRegion.Fire(player);
                        }
                    } else if (inRegion.get(player)) {
                        inRegion.delete(player);
                        leftRegion.Fire(player);
                    }
                });
            } else
                connection.Disconnect();
        }
        connection = RunService.Heartbeat.Connect(() => check(weakRef));
        check(weakRef);
    }


    isInRegion(player: Player) {
        const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
        if (t.instanceIsA("BasePart")(rootPart) && super.regions.some((region) => region.CastPart(rootPart)))
            return true;
        return false;
    }
}

export class ClientRegions extends BaseRegion {
    protected client: Player;

    constructor(parts: BasePart[] | RotatedRegion3[], client = Players.LocalPlayer) {
        super(parts);
        assert(client, "Client argument must be provided on the server");
        this.client = client;
        this.regionCheck(this.enteredRegion, this.leftRegion, this.regions, client);
    }

    protected async regionCheck(enteredRegion: ObjectEvent<[Player]>, leftRegion: ObjectEvent<[Player]>, regions: RotatedRegion3[], client: Player) {
        let connection: RBXScriptConnection;
        let inRegion = false;
        const weakRef = setmetatable({ this: this }, { __mode: "k" });
        const check = (weakRef: { this: ClientRegions }) => {
            if (weakRef.this) {
                const rootPart = client.Character?.FindFirstChild("HumanoidRootPart");
                if (t.instanceIsA("BasePart")(rootPart) && regions.some((region) => region.CastPart(rootPart))) {
                    if (!inRegion) {
                        inRegion = true;
                        enteredRegion.Fire(Players.LocalPlayer);
                    }
                } else if (inRegion) {
                    inRegion = false;
                    leftRegion.Fire(Players.LocalPlayer);
                }
            } else {
                connection.Disconnect();
                print("Garbage collected");
            }
        }
        connection = RunService.Heartbeat.Connect(() => check(weakRef));
        check(weakRef);
    }

    isInRegion() {
        const rootPart = this.client.Character?.FindFirstChild("HumanoidRootPart");
        if (t.instanceIsA("BasePart")(rootPart) && this.regions.some((region) => region.CastPart(rootPart)))
            return true;
        return false;
    }
}