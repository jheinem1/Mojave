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
	function Point:constructor(position, name, canSpawn, safezone, capturePointStatus)
		self.position = position
		self.name = name
		self.canSpawn = canSpawn
		self.safezone = safezone
		self.capturePointStatus = capturePointStatus
		self.controllingFaction = -1
		capturePointStatus.Changed:Connect(function(id)
			self.controllingFaction = id
			return self.controllingFaction
		end)
	end
	function Point:fromPoint(point, position, name, canSpawn, safezone, capturePointStats)
		local _condition = position
		if _condition == nil then
			_condition = point.position
		end
		local _condition_1 = name
		if _condition_1 == nil then
			_condition_1 = point.name
		end
		local _condition_2 = canSpawn
		if _condition_2 == nil then
			_condition_2 = point.canSpawn
		end
		local _condition_3 = safezone
		if _condition_3 == nil then
			_condition_3 = point.safezone
		end
		local _condition_4 = capturePointStats
		if _condition_4 == nil then
			_condition_4 = point.capturePointStatus
		end
		return Point.new(_condition, _condition_1, _condition_2, _condition_3, _condition_4)
	end
end
return {
	Point = Point,
}
