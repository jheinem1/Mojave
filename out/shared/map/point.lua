-- Compiled with roblox-ts v1.1.1
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
		self:constructor(...)
		return self
	end
	function Point:constructor(metatdata)
		self.metatdata = metatdata
		self.x = metatdata.position.X
		self.y = metatdata.position.Y
	end
end
return {
	Point = Point,
}
