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
	function Point:constructor(position, name, canSpawn)
		if canSpawn == nil then
			canSpawn = false
		end
		self.position = position
		self.name = name
		self.canSpawn = canSpawn
	end
end
return {
	Point = Point,
}
