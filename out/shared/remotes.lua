-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Net = TS.import(script, TS.getModule(script, "net").out)
local Remotes = Net.Definitions.Create({
	InSafezone = Net.Definitions.BidirectionalEvent(),
	GetAccessory = Net.Definitions.ServerFunction(),
})
local default = Remotes
return {
	default = default,
}
