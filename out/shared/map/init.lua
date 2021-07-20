-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point").Point
local mapBounds = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point_gen").mapBounds
-- * used for holding all points in a game- generally for spawn locations
local GameMap
do
	GameMap = setmetatable({}, {
		__tostring = function()
			return "GameMap"
		end,
	})
	GameMap.__index = GameMap
	function GameMap.new(...)
		local self = setmetatable({}, GameMap)
		return self:constructor(...) or self
	end
	function GameMap:constructor(points)
		self.points = points
		local _arg0 = function(absPoint)
			return Point:fromPoint(absPoint, Vector2.new(absPoint.position.X, absPoint.position.Y))
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		for _k, _v in ipairs(points) do
			_newValue[_k] = _arg0(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		points = _newValue
		local _binding = mapBounds(points)
		local lower = _binding[1]
		local upper = _binding[2]
		local _arg0_1 = function(absPoint)
			return Point:fromPoint(absPoint, absPoint.position - lower)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue_1 = table.create(#points)
		for _k, _v in ipairs(points) do
			_newValue_1[_k] = _arg0_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		self.points = _newValue_1
		self.size = upper - lower
	end
end
return {
	GameMap = GameMap,
}
