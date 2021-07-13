-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point").Point
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
		self:constructor(...)
		return self
	end
	function GameMap:constructor(points, bounds)
		self.points = points
		self.bounds = bounds
		local _0 = bounds[2]
		local _1 = bounds[1]
		self.size = _0 - _1
		local _2 = points
		local _3 = function(absPoint)
			local _4 = absPoint.position
			local _5 = bounds[1]
			return Point.new(_4 - _5, absPoint.name, absPoint.canSpawn)
		end
		-- ▼ ReadonlyArray.map ▼
		local _4 = table.create(#_2)
		for _5, _6 in ipairs(_2) do
			_4[_5] = _3(_6, _5 - 1, _2)
		end
		-- ▲ ReadonlyArray.map ▲
		self.points = _4
	end
end
return {
	GameMap = GameMap,
}
