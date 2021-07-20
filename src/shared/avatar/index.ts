import { MarketplaceService, Players, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Character, getR15, getR6, R15, R6 } from "./character_types";

export class Avatar {
    appearanceInfo: CharacterAppearanceInfo;
    constructor(public user: Player | number) {
        this.appearanceInfo = Players.GetCharacterAppearanceInfoAsync(t.number(user) ? user : user.UserId);
    }
    loadCharacterR6(): R6 {
        const character = getR6();
        character.SetPrimaryPartCFrame(new CFrame());
        character.HumanoidRootPart.Anchored = true;
        character.Parent = Workspace;
        character.Humanoid.ApplyDescription(Players.GetHumanoidDescriptionFromUserId(t.number(this.user) ? this.user : this.user.UserId));
        character.Parent = undefined;
        return character;
    }
    loadCharacterR15(): R15 {
        const character = getR15();
        character.SetPrimaryPartCFrame(new CFrame());
        character.HumanoidRootPart.Anchored = true;
        character.Parent = Workspace;
        character.Humanoid.ApplyDescription(Players.GetHumanoidDescriptionFromUserId(t.number(this.user) ? this.user : this.user.UserId));
        character.Parent = undefined;
        return character;
    }
    changeShirt<T extends Character>(character: T, newShirtId: number): T {
        const productInfo = MarketplaceService.GetProductInfo(newShirtId, Enum.InfoType.Asset);
        assert(productInfo.AssetTypeId === Enum.AssetType.Image.Value, `Expected image, got "${Enum.AssetType.GetEnumItems().find(assetType => assetType.Value === productInfo.AssetTypeId)}" from '${newShirtId}'`);
        const shirt = character.FindFirstChildWhichIsA("Shirt")
        if (shirt)
            shirt.ShirtTemplate = `rbxassetid://${newShirtId}`;
        else {
            const newShirt = new Instance("Shirt");
            newShirt.ShirtTemplate = `rbxassetid://${newShirtId}`;
            newShirt.Parent = character;
        }
        return character;
    }
    changePants<T extends Character>(character: T, newPantsId: number): T {
        const productInfo = MarketplaceService.GetProductInfo(newPantsId, Enum.InfoType.Asset);
        assert(productInfo.AssetTypeId === Enum.AssetType.Image.Value, `Expected image, got "${Enum.AssetType.GetEnumItems().find(assetType => assetType.Value === productInfo.AssetTypeId)}" from '${newPantsId}'`);
        const pants = character.FindFirstChildWhichIsA("Pants")
        if (pants)
            pants.PantsTemplate = `rbxassetid://${newPantsId}`;
        else {
            const newPants = new Instance("Pants");
            newPants.PantsTemplate = `rbxassetid://${newPantsId}`;
            newPants.Parent = character;
        }
        return character;
    }
}
