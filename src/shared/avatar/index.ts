import { InsertService, MarketplaceService, Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import Remotes from "shared/remotes";
import { Character, getR15, getR6, R15, R6 } from "./character_types";

const accessoryRemote = await Remotes.Client.WaitFor("GetAccessory");

export class Avatar {
    appearanceInfo: CharacterAppearanceInfo;
    constructor(public user: Player | number) {
        this.appearanceInfo = Players.GetCharacterAppearanceInfoAsync(t.number(user) ? user : user.UserId);
    }
    loadCharacter(): R15 {
        const character = getR15();
        const x = new Instance("HumanoidDescription")
        x.GetAccessories(true);
        this.appearanceInfo.assets.forEach(asset => {
            switch (asset.assetType.id) {
                case (Enum.AssetType.Hat.Value):
                case (Enum.AssetType.HairAccessory.Value):
                case (Enum.AssetType.FaceAccessory.Value):
                case (Enum.AssetType.NeckAccessory.Value):
                case (Enum.AssetType.ShoulderAccessory.Value):
                case (Enum.AssetType.FrontAccessory.Value):
                case (Enum.AssetType.BackAccessory.Value):
                case (Enum.AssetType.WaistAccessory.Value):
                case (Enum.AssetType.EarAccessory.Value): {
                    accessoryRemote.CallServerAsync(asset.assetType.id).then(accessory => {
                        if (accessory)
                            character.Humanoid.AddAccessory(accessory);
                    });
                    break;
                }
                case (Enum.AssetType.Shirt.Value): {
                    const instance = new Instance("Shirt");
                    instance.ShirtTemplate = `rbxassetid://${asset.id}`;
                    instance.Parent = character;
                    break;
                }
                case (Enum.AssetType.TeeShirt.Value): {
                    const instance = new Instance("ShirtGraphic");
                    instance.Graphic = `rbxassetid://${asset.id}`;
                    instance.Parent = character;
                    break;
                }
                case (Enum.AssetType.Pants.Value): {
                    const instance = new Instance("Shirt");
                    instance.ShirtTemplate = `rbxassetid://${asset.id}`;
                    instance.Parent = character;
                    break;
                }
                case (Enum.AssetType.Face.Value): {
                    const instance = new Instance("Decal");
                    instance.Texture = `rbxassetid://${asset.id}`;
                    instance.Parent = character;
                    break;
                }
            }
            // if (asset)
            //     if (t.instanceIsA("Accessory")(asset))
            //         character.Humanoid.AddAccessory(asset);
            //     else if (t.instanceIsA("ValueBase")(asset))
            //         asset.Parent = character.Humanoid;
            //     else if (asset.Name === "R15ArtistIntent") {
            //         asset.GetChildren().forEach(bodyPart => {
            //             const bodyPartType = Enum.BodyPartR15.GetEnumItems().find(item => item.Name === bodyPart.Name);
            //             if (t.instanceIsA("BasePart")(bodyPart) && bodyPartType)
            //                 character.Humanoid.ReplaceBodyPartR15(bodyPartType, bodyPart);
            //         });
            //         asset.Destroy();
            //     }
            //     else if (t.union(t.instanceIsA("Clothing"), t.instanceIsA("ShirtGraphic"))(asset))
            //         asset.Parent = character;
            //     else if (t.instanceIsA("SpecialMesh")(asset) && asset.Name === "Mesh") {
            //         character.Head.Mesh.Destroy();
            //         asset.Parent = character.Head;
            //     }
            //     else if (t.instanceIsA("Decal")(asset) && asset.Name === "face") {
            //         character.Head.face.Destroy();
            //         asset.Parent = character.Head;
            //     }
        });
        const bodyColors = new Instance("BodyColors");
        bodyColors.HeadColor = new BrickColor(this.appearanceInfo.bodyColors.headColorId);
        bodyColors.TorsoColor = new BrickColor(this.appearanceInfo.bodyColors.torsoColorId);
        bodyColors.RightArmColor = new BrickColor(this.appearanceInfo.bodyColors.rightArmColorId);
        bodyColors.LeftLegColor = new BrickColor(this.appearanceInfo.bodyColors.leftLegColorId);
        bodyColors.RightLegColor = new BrickColor(this.appearanceInfo.bodyColors.rightLegColorId);
        bodyColors.LeftArmColor = new BrickColor(this.appearanceInfo.bodyColors.leftArmColorId);
        character.Name = t.number(this.user) ? Players.GetNameFromUserIdAsync(this.user) : this.user.Name;
        return character;
    }
    changeShirt<T extends Character>(character: T, newShirtId: number): T {
        const productInfo = MarketplaceService.GetProductInfo(newShirtId, Enum.InfoType.Asset);
        assert(productInfo.AssetTypeId === Enum.AssetType.Shirt.Value, `Expected shirt, got "${Enum.AssetType.GetEnumItems().find(assetType => assetType.Value === productInfo.AssetTypeId)}" from '${newShirtId}'`);
        const newShirt = new Instance("Shirt");
        newShirt.ShirtTemplate = `rbxassetid://${productInfo.AssetId}`;
        character.Shirt?.Destroy();
        newShirt.Parent = character;
        return character;
    }
    changePants<T extends Character>(character: T, newPantsId: number): T {
        const productInfo = MarketplaceService.GetProductInfo(newPantsId, Enum.InfoType.Asset);
        assert(productInfo.AssetTypeId === Enum.AssetType.Pants.Value, `Expected pants, got "${Enum.AssetType.GetEnumItems().find(assetType => assetType.Value === productInfo.AssetTypeId)}" from '${newPantsId}'`);
        const newPants = new Instance("Pants");
        newPants.PantsTemplate = `rbxassetid://${productInfo.AssetId}`;
        character.Pants?.Destroy();
        newPants.Parent = character;
        return character;
    }
    loadCharacterR6(): R6 {
        throw "Method not implemented";
        // const character = getR6();
        // return character;
    }
}
