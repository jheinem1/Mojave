-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Net = TS.import(script, TS.getModule(script, "@rbxts", "net").out)
local SpawnRemotes = Net.Definitions.Create({
	RequestSpawn = Net.Definitions.ServerAsyncFunction(),
	Died = Net.Definitions.ServerToClientEvent(),
})
local default = SpawnRemotes
return {
	default = default,
}
