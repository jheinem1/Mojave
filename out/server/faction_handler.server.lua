-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager")
local quitCaching = _0.quitCaching
local startCaching = _0.startCaching
startCaching()
game:BindToClose(function()
	return quitCaching()
end)
