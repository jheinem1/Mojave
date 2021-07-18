-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, TS.getModule(script, "@rbxts", "services")).ReplicatedStorage
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local GameMap = TS.import(script, script.Parent, "map").GameMap
local _point_gen = TS.import(script, script.Parent, "map", "point_gen")
local genPoints = _point_gen.genPoints
local mapBounds = _point_gen.mapBounds
local location = ReplicatedStorage:WaitForChild("Points", 5)
local _arg0 = t.instanceOf("Folder")(location)
assert(_arg0, "Expected folder in the ReplicatedStorage named 'Points'")
local points = genPoints(location:GetChildren())
local bounds = mapBounds(points)
local gameMap = GameMap.new(points, bounds)
local default = gameMap
return {
	default = default,
}
