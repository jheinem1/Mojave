-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _faction_manager = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager")
local quitCaching = _faction_manager.quitCaching
local startCaching = _faction_manager.startCaching
startCaching()
game:BindToClose(function()
	return quitCaching()
end)
