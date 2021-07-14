-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Net = TS.import(script, TS.getModule(script, "@rbxts", "net").out)
local FactionRemotes = Net.Definitions.Create({
	GetClientInfo = Net.Definitions.ServerFunction(),
})
local default = FactionRemotes
return {
	default = default,
}
