-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local RunService = _services.RunService
if not RunService:IsStudio() then
	Players.PlayerAdded:Connect(function(player)
		if player.AccountAge < 7 then
			player:Kick("Your account must be at least a week old in order to play!")
		end
	end)
end
