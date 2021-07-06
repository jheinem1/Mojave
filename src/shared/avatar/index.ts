import { InsertService, Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import { Character, getR15, getR6, R15, R6 } from "./character_types";

export class Avatar {
    appearanceInfo: CharacterAppearanceInfo;
    constructor(public user: Player | number) {
        this.appearanceInfo = Players.GetCharacterAppearanceInfoAsync(t.number(user) ? user : user.UserId);
    }
    loadCharacter(): R15 {
        const character = getR15();
        this.appearanceInfo.assets.map(asset => InsertService.LoadAsset(asset.id)).forEach(model => {
            const asset = model.FindFirstChildWhichIsA("Instance");
            if (asset)
                if (t.instanceIsA("Accessory")(asset))
                    character.Humanoid.AddAccessory(asset);
                else if (t.instanceIsA("ValueBase")(asset))
                    asset.Parent = character.Humanoid;
                else if (asset.Name === "R15ArtistIntent") {
                    asset.GetChildren().forEach(bodyPart => {
                        const bodyPartType = Enum.BodyPartR15.GetEnumItems().find(item => item.Name === bodyPart.Name);
                        if (t.instanceIsA("BasePart")(bodyPart) && bodyPartType)
                            character.Humanoid.ReplaceBodyPartR15(bodyPartType, bodyPart)
                    });
                    asset.Destroy();
                }
                else if (t.union(t.instanceIsA("Clothing"), t.instanceIsA("ShirtGraphic"))(asset))
                    asset.Parent = character;
                else if (t.instanceIsA("SpecialMesh")(asset) && asset.Name === "Mesh") {
                    character.Head.Mesh.Destroy();
                    asset.Parent = character.Head;
                }
                else if (t.instanceIsA("Decal")(asset) && asset.Name === "face") {
                    character.Head.face.Destroy();
                    asset.Parent = character.Head;
                }
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
        const newShirt = InsertService.LoadAsset(newShirtId).FindFirstChildWhichIsA("Shirt");
        assert(newShirt, `Expected shirt, got [${InsertService.LoadAsset(newShirtId).GetChildren().map(tostring).join()}] from '${newShirtId}'`);
        character.Shirt?.Destroy();
        newShirt.Parent = character;
        return character;
    }
    changePants<T extends Character>(character: T, newPantsId: number): T {
        const newPants = InsertService.LoadAsset(newPantsId).FindFirstChildWhichIsA("Pants");
        assert(newPants, `Expected pants, got [${InsertService.LoadAsset(newPantsId).GetChildren().map(tostring).join()}] from '${newPantsId}'`);
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
