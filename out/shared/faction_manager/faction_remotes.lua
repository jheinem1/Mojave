-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Net = TS.import(script, TS.getModule(script, "net").out)
local FactionRemotes = Net.Definitions.Create({
	GetClientInfo = Net.Definitions.ServerFunction(),
})
local default = FactionRemotes
return {
	default = default,
}
