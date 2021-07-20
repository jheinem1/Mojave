-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, TS.getModule(script, "@rbxts", "services")).ReplicatedStorage
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local GameMap = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map").GameMap
local genPoints = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point_gen").genPoints
local location = ReplicatedStorage:WaitForChild("Points", 5)
local _arg0 = t.instanceOf("Folder")(location)
assert(_arg0, "Expected folder in the ReplicatedStorage named 'Points'")
local points = genPoints(location:GetChildren())
local gameMap = GameMap.new(points)
local default = gameMap
return {
	default = default,
}
