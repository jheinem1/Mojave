-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Point = TS.import(script, script, "point").Point
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
	function GameMap:constructor(points, bounds)
		self.points = points
		self.bounds = bounds
		local _exp = bounds[2]
		local _arg0 = bounds[1]
		self.size = _exp - _arg0
		local _arg0_1 = function(absPoint)
			local _position = absPoint.position
			local _arg0_2 = bounds[1]
			return Point.new(_position - _arg0_2, absPoint.name, absPoint.canSpawn, absPoint.safezone)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#points)
		for _k, _v in ipairs(points) do
			_newValue[_k] = _arg0_1(_v, _k - 1, points)
		end
		-- ▲ ReadonlyArray.map ▲
		self.points = _newValue
	end
end
return {
	GameMap = GameMap,
}
