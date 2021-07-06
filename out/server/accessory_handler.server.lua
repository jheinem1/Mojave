-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local MarketplaceService = TS.import(script, TS.getModule(script, "services")).MarketplaceService
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local remote = Remotes.Server:Create("GetAccessory")
remote:SetCallback(function(_player, id)
	local productInfo = MarketplaceService:GetProductInfo(id, Enum.InfoType.Asset)
	if productInfo.AssetTypeId then
		return nil
	end
end)
