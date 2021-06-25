import ObjectEvent from "@rbxts/object-event";
import RotatedRegion3 from "@rbxts/rotatedregion3";
import { Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";

abstract class BaseRegion {
    protected parts = new Array<BasePart>();
    protected regions = new Array<RotatedRegion3>();
    protected disabled = false;
    enteredRegion = new ObjectEvent<[Player]>();
    leftRegion = new ObjectEvent<[Player]>();

    constructor(parts: BasePart[]) {
        parts.forEach(part => {
            parts.push(part);
            this.regions.push(RotatedRegion3.FromPart(part));
        });

        this.regionCheck();
    }

    protected abstract regionCheck(): void;

    abstract isInRegion(player: Player): boolean;
}

export class GlobalRegions extends BaseRegion {
    protected inRegion = new WeakMap<Player, boolean>();

    protected async regionCheck() {
        let connection: RBXScriptConnection;
        const weakRef = setmetatable({ this: this }, { __mode: "k" })
        connection = RunService.Heartbeat.Connect(() => {
            if (weakRef.this) {
                Players.GetPlayers().forEach(player => {
                    const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
                    if (t.instanceIsA("BasePart")(rootPart) && super.regions.some((region) => region.CastPart(rootPart))) {
                        if (!weakRef.this.inRegion.get(player)) {
                            weakRef.this.inRegion.set(player, true);
                            weakRef.this.enteredRegion.Fire(player);
                        }
                    } else if (weakRef.this.inRegion.get(player)) {
                        weakRef.this.inRegion.delete(player);
                        weakRef.this.leftRegion.Fire(player);
                    }
                });
            } else
                connection.Disconnect();
        });
    }

    isInRegion(player: Player): boolean {
        return this.inRegion.get(player) ?? false;
    }
}

export class ClientRegions extends BaseRegion {
    protected inRegion = false;

    protected async regionCheck() {
        let connection: RBXScriptConnection;
        const weakRef = setmetatable({ this: this }, { __mode: "k" })
        connection = RunService.Heartbeat.Connect(() => {
            if (weakRef.this) {
                const rootPart = Players.LocalPlayer.Character?.FindFirstChild("HumanoidRootPart");
                if (t.instanceIsA("BasePart")(rootPart) && weakRef.this.regions.some((region) => region.CastPart(rootPart))) {
                    if (!weakRef.this.inRegion) {
                        weakRef.this.inRegion = true;
                        weakRef.this.enteredRegion.Fire(Players.LocalPlayer);
                    }
                } else if (this.inRegion) {
                    weakRef.this.inRegion = false;
                    weakRef.this.leftRegion.Fire(Players.LocalPlayer);
                }
            } else
                connection.Disconnect();
        });
    }

    isInRegion() {
        return this.inRegion;
    }
}