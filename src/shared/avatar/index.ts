import { Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import { getR15, R15 } from "./character_types";

export class Avatar {
    appearanceInfo: CharacterAppearanceInfo;
    constructor(public user: Player | number) {
        this.appearanceInfo = Players.GetCharacterAppearanceInfoAsync(t.number(user) ? user : user.UserId);
    }
    loadCharacter(): R15 {
        return getR15()
    }
}
