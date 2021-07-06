-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local MarketplaceService = _0.MarketplaceService
local Players = _0.Players
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local getR15 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar", "character_types").getR15
local accessoryRemote = Remotes.Client:WaitFor("GetAccessory")
local Avatar
do
	Avatar = setmetatable({}, {
		__tostring = function()
			return "Avatar"
		end,
	})
	Avatar.__index = Avatar
	function Avatar.new(...)
		local self = setmetatable({}, Avatar)
		self:constructor(...)
		return self
	end
	function Avatar:constructor(user)
		self.user = user
		self.appearanceInfo = Players:GetCharacterAppearanceInfoAsync(t.number(user) and user or user.UserId)
	end
	function Avatar:loadCharacter()
		local character = getR15()
		-- this.appearanceInfo.assets.forEach(asset => {
		-- print(asset)
		-- switch (asset.assetType.id) {
		-- case (Enum.AssetType.Hat.Value):
		-- case (Enum.AssetType.HairAccessory.Value):
		-- case (Enum.AssetType.FaceAccessory.Value):
		-- case (Enum.AssetType.NeckAccessory.Value):
		-- case (Enum.AssetType.ShoulderAccessory.Value):
		-- case (Enum.AssetType.FrontAccessory.Value):
		-- case (Enum.AssetType.BackAccessory.Value):
		-- case (Enum.AssetType.WaistAccessory.Value):
		-- case (Enum.AssetType.EarAccessory.Value): {
		-- accessoryRemote.then(remote => remote.SendToServer(asset.id));
		-- break;
		-- }
		-- case (Enum.AssetType.Shirt.Value): {
		-- const instance = new Instance("Shirt");
		-- instance.ShirtTemplate = `rbxassetid://${asset.id}`;
		-- instance.Name = "Shirt";
		-- instance.Parent = character;
		-- break;
		-- }
		-- case (Enum.AssetType.TeeShirt.Value): {
		-- const instance = new Instance("ShirtGraphic");
		-- instance.Graphic = `rbxassetid://${asset.id}`;
		-- instance.Name = "ShirtGraphic";
		-- instance.Parent = character;
		-- break;
		-- }
		-- case (Enum.AssetType.Pants.Value): {
		-- const instance = new Instance("Pants");
		-- instance.PantsTemplate = `rbxassetid://${asset.id}`;
		-- instance.Name = "Pants";
		-- instance.Parent = character;
		-- break;
		-- }
		-- case (Enum.AssetType.Face.Value): {
		-- const instance = new Instance("Decal");
		-- instance.Texture = `rbxassetid://${asset.id}`;
		-- instance.Name = "face";
		-- character.Head.face.Destroy();
		-- instance.Parent = character.Head;
		-- break;
		-- }
		-- case (Enum.AssetType.Head.Value): {
		-- const instance = new Instance("SpecialMesh");
		-- instance.MeshId = `rbxassetid://${asset.id}`;
		-- instance.Name = "Mesh";
		-- character.Head.Mesh.Destroy();
		-- }
		-- }
		-- // if (asset)
		-- //     if (t.instanceIsA("Accessory")(asset))
		-- //         character.Humanoid.AddAccessory(asset);
		-- //     else if (t.instanceIsA("ValueBase")(asset))
		-- //         asset.Parent = character.Humanoid;
		-- //     else if (asset.Name === "R15ArtistIntent") {
		-- //         asset.GetChildren().forEach(bodyPart => {
		-- //             const bodyPartType = Enum.BodyPartR15.GetEnumItems().find(item => item.Name === bodyPart.Name);
		-- //             if (t.instanceIsA("BasePart")(bodyPart) && bodyPartType)
		-- //                 character.Humanoid.ReplaceBodyPartR15(bodyPartType, bodyPart);
		-- //         });
		-- //         asset.Destroy();
		-- //     }
		-- //     else if (t.union(t.instanceIsA("Clothing"), t.instanceIsA("ShirtGraphic"))(asset))
		-- //         asset.Parent = character;
		-- //     else if (t.instanceIsA("SpecialMesh")(asset) && asset.Name === "Mesh") {
		-- //         character.Head.Mesh.Destroy();
		-- //         asset.Parent = character.Head;
		-- //     }
		-- //     else if (t.instanceIsA("Decal")(asset) && asset.Name === "face") {
		-- //         character.Head.face.Destroy();
		-- //         asset.Parent = character.Head;
		-- //     }
		-- });
		-- const bodyColors = new Instance("BodyColors");
		-- bodyColors.HeadColor = new BrickColor(this.appearanceInfo.bodyColors.headColorId);
		-- bodyColors.TorsoColor = new BrickColor(this.appearanceInfo.bodyColors.torsoColorId);
		-- bodyColors.RightArmColor = new BrickColor(this.appearanceInfo.bodyColors.rightArmColorId);
		-- bodyColors.LeftLegColor = new BrickColor(this.appearanceInfo.bodyColors.leftLegColorId);
		-- bodyColors.RightLegColor = new BrickColor(this.appearanceInfo.bodyColors.rightLegColorId);
		-- bodyColors.LeftArmColor = new BrickColor(this.appearanceInfo.bodyColors.leftArmColorId);
		-- character.Name = t.number(this.user) ? Players.GetNameFromUserIdAsync(this.user) : this.user.Name;
		character.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(t.number(self.user) and self.user or self.user.UserId))
		return character
	end
	function Avatar:changeShirt(character, newShirtId)
		local productInfo = MarketplaceService:GetProductInfo(newShirtId, Enum.InfoType.Asset)
		local _1 = productInfo.AssetTypeId == Enum.AssetType.Shirt.Value
		local _2 = Enum.AssetType:GetEnumItems()
		local _3 = function(assetType)
			return assetType.Value == productInfo.AssetTypeId
		end
		-- ▼ ReadonlyArray.find ▼
		local _4 = nil
		for _5, _6 in ipairs(_2) do
			if _3(_6, _5 - 1, _2) == true then
				_4 = _6
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local _5 = 'Expected shirt, got "' .. tostring(_4) .. [[" from ']] .. tostring(newShirtId) .. "'"
		assert(_1, _5)
		local newShirt = Instance.new("Shirt")
		newShirt.ShirtTemplate = "rbxassetid://" .. tostring(productInfo.AssetId)
		local _6 = character.Shirt
		if _6 ~= nil then
			_6:Destroy()
		end
		newShirt.Parent = character
		return character
	end
	function Avatar:changePants(character, newPantsId)
		local productInfo = MarketplaceService:GetProductInfo(newPantsId, Enum.InfoType.Asset)
		local _1 = productInfo.AssetTypeId == Enum.AssetType.Pants.Value
		local _2 = Enum.AssetType:GetEnumItems()
		local _3 = function(assetType)
			return assetType.Value == productInfo.AssetTypeId
		end
		-- ▼ ReadonlyArray.find ▼
		local _4 = nil
		for _5, _6 in ipairs(_2) do
			if _3(_6, _5 - 1, _2) == true then
				_4 = _6
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local _5 = 'Expected pants, got "' .. tostring(_4) .. [[" from ']] .. tostring(newPantsId) .. "'"
		assert(_1, _5)
		local newPants = Instance.new("Pants")
		newPants.PantsTemplate = "rbxassetid://" .. tostring(productInfo.AssetId)
		local _6 = character.Pants
		if _6 ~= nil then
			_6:Destroy()
		end
		newPants.Parent = character
		return character
	end
	function Avatar:loadCharacterR6()
		error("Method not implemented")
		-- const character = getR6();
		-- return character;
	end
end
return {
	Avatar = Avatar,
}
