-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local gameMap = TS.import(script, script.Parent.Parent.Parent.Parent, "client_points_handler").default
local Screen = TS.import(script, script.Parent, "screen").Screen
local MapPointComponent = TS.import(script, script, "map_point").MapPointComponent
local MapComponent
do
	MapComponent = Roact.Component:extend("MapComponent")
	function MapComponent:init(props)
		local _points = gameMap.points
		local _arg0 = function(point)
			return Roact.createElement(MapPointComponent, {
				point = point,
				size = gameMap.size,
			})
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_points)
		for _k, _v in ipairs(_points) do
			_newValue[_k] = _arg0(_v, _k - 1, _points)
		end
		-- ▲ ReadonlyArray.map ▲
		self.mapPoints = _newValue
	end
	function MapComponent:render()
		local _ptr = {
			BackgroundColor3 = Color3.fromRGB(126, 111, 42),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 36),
			Size = UDim2.new(1, 0, 1, -36),
		}
		local _ptr_1 = {}
		local _length = #_ptr_1
		for _k, _v in ipairs(self.mapPoints) do
			_ptr_1[_length + _k] = _v
		end
		_length = #_ptr_1
		return Roact.createFragment({
			Map = Roact.createElement("Frame", _ptr, _ptr_1),
		})
	end
end
local MapScreen
do
	local super = Screen
	MapScreen = setmetatable({}, {
		__tostring = function()
			return "MapScreen"
		end,
		__index = super,
	})
	MapScreen.__index = MapScreen
	function MapScreen.new(...)
		local self = setmetatable({}, MapScreen)
		return self:constructor(...) or self
	end
	function MapScreen:constructor(position, currentScreen, finished)
		super.constructor(self, position, currentScreen)
		self.position = position
		self.currentScreen = currentScreen
		self.finished = finished
		self.name = "Spawn"
	end
	function MapScreen:getScreenComponent()
		return Roact.createElement(MapComponent, {
			finished = self.finished,
		})
	end
end
return {
	MapScreen = MapScreen,
}
