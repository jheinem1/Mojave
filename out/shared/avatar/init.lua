-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local MarketplaceService = _0.MarketplaceService
local Players = _0.Players
local Workspace = _0.Workspace
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
		character:SetPrimaryPartCFrame(CFrame.new())
		character.HumanoidRootPart.Anchored = true
		character.Parent = Workspace
		character.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(t.number(self.user) and self.user or self.user.UserId))
		character.Parent = nil
		return character
	end
	function Avatar:changeShirt(character, newShirtId)
		local productInfo = MarketplaceService:GetProductInfo(newShirtId, Enum.InfoType.Asset)
		local _1 = productInfo.AssetTypeId == Enum.AssetType.Image.Value
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
		local _5 = 'Expected image, got "' .. tostring(_4) .. [[" from ']] .. tostring(newShirtId) .. "'"
		assert(_1, _5)
		-- const newShirt = new Instance("Shirt");
		-- newShirt.ShirtTemplate = `rbxassetid://${productInfo.AssetId}`;
		-- character.Shirt?.Destroy();
		-- newShirt.Parent = character;
		if character.Humanoid.HumanoidDescription then
			character.Humanoid.HumanoidDescription.Shirt = productInfo.AssetId
			local oldParent = character.Parent
			character.Parent = Workspace
			character.Humanoid:ApplyDescription(character.Humanoid.HumanoidDescription)
			character.Parent = oldParent
		end
		return character
	end
	function Avatar:changePants(character, newPantsId)
		local productInfo = MarketplaceService:GetProductInfo(newPantsId, Enum.InfoType.Asset)
		local _1 = productInfo.AssetTypeId == Enum.AssetType.Image.Value
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
		local _5 = 'Expected image, got "' .. tostring(_4) .. [[" from ']] .. tostring(newPantsId) .. "'"
		assert(_1, _5)
		-- const newPants = new Instance("Pants");
		-- newPants.PantsTemplate = `rbxassetid://${productInfo.AssetId}`;
		-- character.Pants?.Destroy();
		-- newPants.Parent = character;
		if character.Humanoid.HumanoidDescription then
			character.Humanoid.HumanoidDescription.Pants = productInfo.AssetId
			local oldParent = character.Parent
			character.Parent = Workspace
			character.Humanoid:ApplyDescription(character.Humanoid.HumanoidDescription)
			character.Parent = oldParent
		end
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
