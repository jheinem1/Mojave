-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local ReplicatedStorage = _0.ReplicatedStorage
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local ClientRegions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "regions").ClientRegions
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Client:Get("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _1 = Workspace:FindFirstChild("Safezones")
if _1 == nil then
	_1 = ReplicatedStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _1
local _2 = safezoneFolder
assert(_2, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage")
local safezoneParts = safezoneFolder:GetChildren()
local _3 = validSafezoneChildren(safezoneParts)
assert(_3, "Expected children of 'Safezones' folder to be BaseParts")
local SafezoneRegions = ClientRegions.new(safezoneParts)
local shielded = false
inSafezone:Connect(function(isInSafezone)
	if isInSafezone then
		shielded = true
	else
		shielded = false
	end
end)
SafezoneRegions.enteredRegion:Connect(function()
	if not shielded then
		shielded = true
		inSafezone:SendToServer(true)
	end
end)
