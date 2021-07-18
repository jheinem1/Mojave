-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local __ = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions")
local quitCaching = __.quitCaching
local startCaching = __.startCaching
startCaching()
game:BindToClose(function()
	return quitCaching()
end)
