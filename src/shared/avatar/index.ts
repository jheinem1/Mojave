import { MarketplaceService, Players, Workspace } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Character, getR15, R15, R6 } from "./character_types";

export class Avatar {
    appearanceInfo: CharacterAppearanceInfo;
    constructor(public user: Player | number) {
        this.appearanceInfo = Players.GetCharacterAppearanceInfoAsync(t.number(user) ? user : user.UserId);
    }
    loadCharacter(): R15 {
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
        // const newShirt = new Instance("Shirt");
        // newShirt.ShirtTemplate = `rbxassetid://${productInfo.AssetId}`;
        // character.Shirt?.Destroy();
        // newShirt.Parent = character;
        if (character.Humanoid.HumanoidDescription) {
            character.Humanoid.HumanoidDescription.Shirt = productInfo.AssetId;
            const oldParent = character.Parent;
            character.Parent = Workspace;
            character.Humanoid.ApplyDescription(character.Humanoid.HumanoidDescription);
            character.Parent = oldParent;
        }
        return character;
    }
    changePants<T extends Character>(character: T, newPantsId: number): T {
        const productInfo = MarketplaceService.GetProductInfo(newPantsId, Enum.InfoType.Asset);
        assert(productInfo.AssetTypeId === Enum.AssetType.Image.Value, `Expected image, got "${Enum.AssetType.GetEnumItems().find(assetType => assetType.Value === productInfo.AssetTypeId)}" from '${newPantsId}'`);
        // const newPants = new Instance("Pants");
        // newPants.PantsTemplate = `rbxassetid://${productInfo.AssetId}`;
        // character.Pants?.Destroy();
        // newPants.Parent = character;
        if (character.Humanoid.HumanoidDescription) {
            character.Humanoid.HumanoidDescription.Pants = productInfo.AssetId;
            const oldParent = character.Parent;
            character.Parent = Workspace;
            character.Humanoid.ApplyDescription(character.Humanoid.HumanoidDescription);
            character.Parent = oldParent;
        }
        return character;
    }
    loadCharacterR6(): R6 {
        throw "Method not implemented";
        // const character = getR6();
        // return character;
    }
}
