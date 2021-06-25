-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local ReplicatedStorage = _0.ReplicatedStorage
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
-- basically it just moves a folder to replicatedstorage
local _1 = Workspace:FindFirstChild("LightRegions")
if _1 == nil then
	_1 = ReplicatedStorage:FindFirstChild("LightRegions")
end
local lightingRegions = _1
local _2 = lightingRegions
assert(_2, "A folder in the workspace/Replicated name 'LightRegions' is required")
local lightingRegionsParts = lightingRegions:GetChildren()
local _3 = t.array(t.instanceIsA("BasePart"))(lightingRegionsParts)
assert(_3, "Children of 'LightRegions' must be BaseParts")
lightingRegions.Parent = ReplicatedStorage
