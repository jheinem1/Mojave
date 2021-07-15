-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local _condition = Workspace:FindFirstChild("Points")
if _condition == nil then
	_condition = ReplicatedStorage:FindFirstChild("Points")
end
local location = _condition
local _arg0 = t.instanceOf("Folder")(location)
assert(_arg0, "Expected folder in the Workspace or ReplicatedStorage named 'Points'")
location.Parent = ReplicatedStorage
