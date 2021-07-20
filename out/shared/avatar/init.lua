-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local MarketplaceService = _services.MarketplaceService
local Players = _services.Players
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local _character_types = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar", "character_types")
local getR15 = _character_types.getR15
local getR6 = _character_types.getR6
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
	function Avatar:loadCharacterR6()
		local character = getR6()
		character:SetPrimaryPartCFrame(CFrame.new())
		character.HumanoidRootPart.Anchored = true
		character.Parent = Workspace
		character.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(t.number(self.user) and self.user or self.user.UserId))
		character.Parent = nil
		return character
	end
	function Avatar:loadCharacterR15()
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
		local shirt = character:FindFirstChildWhichIsA("Shirt")
		if shirt then
			shirt.ShirtTemplate = "rbxassetid://" .. tostring(newShirtId)
		else
			local newShirt = Instance.new("Shirt")
			newShirt.ShirtTemplate = "rbxassetid://" .. tostring(newShirtId)
			newShirt.Parent = character
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
		local pants = character:FindFirstChildWhichIsA("Pants")
		if pants then
			pants.PantsTemplate = "rbxassetid://" .. tostring(newPantsId)
		else
			local newPants = Instance.new("Pants")
			newPants.PantsTemplate = "rbxassetid://" .. tostring(newPantsId)
			newPants.Parent = character
		end
		return character
	end
end
return {
	Avatar = Avatar,
}
