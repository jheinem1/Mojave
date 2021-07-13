-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Screen = TS.import(script, script.Parent, "screen").Screen
local MapComponent
do
	MapComponent = Roact.Component:extend("MapComponent")
	function MapComponent:init()
	end
	function MapComponent:render()
		return Roact.createFragment({
			Map = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(126, 111, 42),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 36),
				Size = UDim2.new(1, 0, 1, -36),
			}, {
				MapImage = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, -960, 0, 0),
					Size = UDim2.new(0, 1920, 1, 0),
				}),
			}),
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
		self:constructor(...)
		return self
	end
	function MapScreen:constructor(...)
		super.constructor(self, ...)
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
