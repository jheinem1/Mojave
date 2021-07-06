-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local MarketplaceService = _0.MarketplaceService
local Players = _0.Players
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local getR15 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar", "character_types").getR15
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
		local _1 = self.appearanceInfo.assets
		local _2 = function(asset)
			local _3 = asset.assetType.id
			repeat
				local _4 = false
				if _3 == ((Enum.AssetType.HairAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.FaceAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.NeckAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.ShoulderAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.FrontAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.BackAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.WaistAccessory.Value)) then
					_4 = true
				end
				if _4 or _3 == ((Enum.AssetType.EarAccessory.Value)) then
				end
			until true
			-- if (asset)
			-- if (t.instanceIsA("Accessory")(asset))
			-- character.Humanoid.AddAccessory(asset);
			-- else if (t.instanceIsA("ValueBase")(asset))
			-- asset.Parent = character.Humanoid;
			-- else if (asset.Name === "R15ArtistIntent") {
			-- asset.GetChildren().forEach(bodyPart => {
			-- const bodyPartType = Enum.BodyPartR15.GetEnumItems().find(item => item.Name === bodyPart.Name);
			-- if (t.instanceIsA("BasePart")(bodyPart) && bodyPartType)
			-- character.Humanoid.ReplaceBodyPartR15(bodyPartType, bodyPart);
			-- });
			-- asset.Destroy();
			-- }
			-- else if (t.union(t.instanceIsA("Clothing"), t.instanceIsA("ShirtGraphic"))(asset))
			-- asset.Parent = character;
			-- else if (t.instanceIsA("SpecialMesh")(asset) && asset.Name === "Mesh") {
			-- character.Head.Mesh.Destroy();
			-- asset.Parent = character.Head;
			-- }
			-- else if (t.instanceIsA("Decal")(asset) && asset.Name === "face") {
			-- character.Head.face.Destroy();
			-- asset.Parent = character.Head;
			-- }
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _3, _4 in ipairs(_1) do
			_2(_4, _3 - 1, _1)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local bodyColors = Instance.new("BodyColors")
		bodyColors.HeadColor = BrickColor.new(self.appearanceInfo.bodyColors.headColorId)
		bodyColors.TorsoColor = BrickColor.new(self.appearanceInfo.bodyColors.torsoColorId)
		bodyColors.RightArmColor = BrickColor.new(self.appearanceInfo.bodyColors.rightArmColorId)
		bodyColors.LeftLegColor = BrickColor.new(self.appearanceInfo.bodyColors.leftLegColorId)
		bodyColors.RightLegColor = BrickColor.new(self.appearanceInfo.bodyColors.rightLegColorId)
		bodyColors.LeftArmColor = BrickColor.new(self.appearanceInfo.bodyColors.leftArmColorId)
		character.Name = t.number(self.user) and Players:GetNameFromUserIdAsync(self.user) or self.user.Name
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
