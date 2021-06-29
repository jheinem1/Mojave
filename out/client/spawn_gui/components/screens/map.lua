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
				MapImage = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://7010013959",
					Position = UDim2.new(0.5, -960, 0, 0),
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.new(0, 1920, 1, 0),
					SliceScale = 0,
				}, {
					Destination = Roact.createElement("TextButton", {
						BackgroundColor3 = Color3.fromRGB(193, 193, 193),
						BorderColor3 = Color3.fromRGB(255, 226, 86),
						BorderSizePixel = 5,
						Font = Enum.Font.SourceSans,
						Position = UDim2.new(0.562, 0, 0.643, 0),
						Size = UDim2.new(0, 25, 0, 25),
						Text = "",
						TextColor3 = Color3.fromRGB(0, 0, 0),
						TextSize = 14,
					}),
					Tooltip = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(126, 111, 42),
						BorderColor3 = Color3.fromRGB(255, 226, 86),
						BorderSizePixel = 3,
						Position = UDim2.new(0, 1150, 0, 550),
						Size = UDim2.new(0, 283, 0, 60),
					}, {
						DestinationInfo = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.SourceSansSemibold,
							Position = UDim2.new(0, 5, 0, 0),
							Size = UDim2.new(1, -10, 1, 0),
							Text = "Hoover Dam\nControlling Faction: NCR",
							TextColor3 = Color3.fromRGB(255, 226, 86),
							TextSize = 32,
							TextXAlignment = Enum.TextXAlignment.Left,
						}),
						Tooltip = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(126, 111, 42),
							BorderColor3 = Color3.fromRGB(255, 226, 86),
							BorderSizePixel = 3,
							Position = UDim2.new(0, 0, 1, 3),
							Size = UDim2.new(0, 283, 0, 32),
						}, {
							SpawnButton = Roact.createElement("TextLabel", {
								BackgroundTransparency = 1,
								Font = Enum.Font.SourceSansBold,
								Position = UDim2.new(0, 5, 0, 0),
								Size = UDim2.new(1, -10, 1, 0),
								Text = "SPAWN",
								TextColor3 = Color3.fromRGB(255, 226, 86),
								TextSize = 32,
							}),
						}),
					}),
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
	end
	function MapScreen:getScreenComponent(onSpawn)
		error("Method not implemented.")
	end
	function MapScreen:getButtonComponent(onSelect)
		error("Method not implemented.")
	end
end
return {
	MapScreen = MapScreen,
}
