-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local InsertService = _0.InsertService
local MarketplaceService = _0.MarketplaceService
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local remote = Remotes.Server:Create("GetAccessory")
remote:SetCallback(function(player, id)
	local _1, _2 = TS.try(function()
		local productInfo = MarketplaceService:GetProductInfo(id, Enum.InfoType.Asset)
		local _3 = productInfo.AssetTypeId
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
				local asset = InsertService:LoadAsset(id)
				asset.Parent = nil
				return TS.TRY_RETURN, { asset:FindFirstAncestorWhichIsA("Accessory") }
			end
		until true
	end, function()
		warn("Failed to load asset '" .. tostring(id) .. "' for " .. tostring(player) .. "'")
		return TS.TRY_RETURN, { nil }
	end)
	if _1 then
		return unpack(_2)
	end
end)
