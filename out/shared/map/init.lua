-- Compiled with roblox-ts v1.1.1
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
	function GameMap:constructor(points)
		self.points = points
	end
end
return {
	GameMap = GameMap,
}
