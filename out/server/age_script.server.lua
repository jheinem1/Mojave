-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
Players.PlayerAdded:Connect(function(player)
	if player.AccountAge < 7 then
		player:Kick("Your account must be at least a week old in order to play.")
	end
end)
