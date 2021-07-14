-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local MarketplaceService = _services.MarketplaceService
local Players = _services.Players
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
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
		return self:constructor(...) or self
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
		local _exp = productInfo.AssetTypeId == Enum.AssetType.Image.Value
		local _exp_1 = Enum.AssetType:GetEnumItems()
		local _arg0 = function(assetType)
			return assetType.Value == productInfo.AssetTypeId
		end
		-- ▼ ReadonlyArray.find ▼
		local _result = nil
		for _i, _v in ipairs(_exp_1) do
			if _arg0(_v, _i - 1, _exp_1) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local _arg1 = 'Expected image, got "' .. tostring(_result) .. [[" from ']] .. tostring(newShirtId) .. "'"
		assert(_exp, _arg1)
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
		local _exp = productInfo.AssetTypeId == Enum.AssetType.Image.Value
		local _exp_1 = Enum.AssetType:GetEnumItems()
		local _arg0 = function(assetType)
			return assetType.Value == productInfo.AssetTypeId
		end
		-- ▼ ReadonlyArray.find ▼
		local _result = nil
		for _i, _v in ipairs(_exp_1) do
			if _arg0(_v, _i - 1, _exp_1) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local _arg1 = 'Expected image, got "' .. tostring(_result) .. [[" from ']] .. tostring(newPantsId) .. "'"
		assert(_exp, _arg1)
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
