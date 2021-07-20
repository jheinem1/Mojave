-- Compiled with roblox-ts v1.2.2
-- * a 2d point in the game- generally used for spawn locations
local Point
do
	Point = setmetatable({}, {
		__tostring = function()
			return "Point"
		end,
	})
	Point.__index = Point
	function Point.new(...)
		local self = setmetatable({}, Point)
		return self:constructor(...) or self
	end
	function Point:constructor(position, name, safezone, capturePointStatus, spawnPoints)
		self.position = position
		self.name = name
		self.safezone = safezone
		self.capturePointStatus = capturePointStatus
		self.spawnPoints = spawnPoints
		self.controllingFaction = -1
		self.controllingFaction = capturePointStatus.Value
		capturePointStatus.Changed:Connect(function(id)
			self.controllingFaction = id
			return self.controllingFaction
		end)
		local _result
		if spawnPoints then
			_result = #spawnPoints > 0
		else
			_result = false
		end
		self.canSpawn = _result
	end
	function Point:fromPoint(point, position, name, safezone, capturePointStats, spawnPoints)
		local _condition = position
		if _condition == nil then
			_condition = point.position
		end
		local _condition_1 = name
		if _condition_1 == nil then
			_condition_1 = point.name
		end
		local _condition_2 = safezone
		if _condition_2 == nil then
			_condition_2 = point.safezone
		end
		local _condition_3 = capturePointStats
		if _condition_3 == nil then
			_condition_3 = point.capturePointStatus
		end
		local _condition_4 = spawnPoints
		if _condition_4 == nil then
			_condition_4 = point.spawnPoints
		end
		return Point.new(_condition, _condition_1, _condition_2, _condition_3, _condition_4)
	end
end
return {
	Point = Point,
}
