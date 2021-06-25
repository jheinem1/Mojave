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

    disable() {
        this.disabled = true;
    }

    reEnable() {
        this.disabled = false;
    }

    protected abstract regionCheck(): void;

    abstract isInRegion(player: Player): boolean;
}

export class GlobalRegions extends BaseRegion {
    protected inRegion = new WeakMap<Player, boolean>();

    protected async regionCheck() {
        RunService.Heartbeat.Connect(() => {
            Players.GetPlayers().forEach(player => {
                if (!this.disabled) {
                    const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
                    if (t.instanceIsA("BasePart")(rootPart) && super.regions.some((region) => region.CastPart(rootPart))) {
                        if (!this.inRegion.get(player)) {
                            this.inRegion.set(player, true);
                            this.enteredRegion.Fire(player);
                        }
                    } else if (this.inRegion.get(player)) {
                        this.inRegion.delete(player);
                        this.leftRegion.Fire(player);
                    }
                }
            });
        });
    }

    isInRegion(player: Player): boolean {
        return this.inRegion.get(player) ?? false;
    }
}

export class ClientRegions extends BaseRegion {
    protected inRegion = false;

    protected async regionCheck() {
        RunService.Heartbeat.Connect(() => {
            if (!this.disabled) {
                const rootPart = Players.LocalPlayer.Character?.FindFirstChild("HumanoidRootPart");
                if (t.instanceIsA("BasePart")(rootPart) && super.regions.some((region) => region.CastPart(rootPart))) {
                    if (!this.inRegion) {
                        this.inRegion = true;
                        super.enteredRegion.Fire(Players.LocalPlayer);
                    }
                } else if (this.inRegion) {
                    this.inRegion = false;
                    super.leftRegion.Fire(Players.LocalPlayer);
                }
            }
        });
    }

    isInRegion() {
        return this.inRegion;
    }
}