-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Screen = TS.import(script, script.Parent, "screen").Screen
local TeamsComponent
do
	TeamsComponent = Roact.Component:extend("TeamsComponent")
	function TeamsComponent:init()
	end
	function TeamsComponent:render()
		return Roact.createFragment({
			Teams = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 36),
				Size = UDim2.new(1, 0, 1, -36),
				Visible = false,
			}, {
				Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateFull = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(46, 46, 46),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.3, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
					Faction = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamSemibold,
						Size = UDim2.new(1, 0, 0.25, 0),
						Text = "NCR",
						TextColor3 = Color3.fromRGB(255, 208, 80),
						TextScaled = true,
						TextSize = 100,
						TextWrapped = true,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
				TeamTemplateMinimized = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(23, 23, 23),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					Size = UDim2.new(0.1, 0, 1, 0),
				}, {
					Avatar = Roact.createElement("ViewportFrame", {
						Ambient = Color3.fromRGB(106, 106, 106),
						BackgroundTransparency = 1,
						LightColor = Color3.fromRGB(255, 255, 255),
						LightDirection = Vector3.new(2, -1, -1),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
			}),
		})
	end
end
local TeamsScreen
do
	local super = Screen
	TeamsScreen = setmetatable({}, {
		__tostring = function()
			return "TeamsScreen"
		end,
		__index = super,
	})
	TeamsScreen.__index = TeamsScreen
	function TeamsScreen.new(...)
		local self = setmetatable({}, TeamsScreen)
		self:constructor(...)
		return self
	end
	function TeamsScreen:constructor(...)
		super.constructor(self, ...)
	end
	function TeamsScreen:getScreenComponent(onSpawn)
		error("Method not implemented.")
	end
	function TeamsScreen:getButtonComponent(onSelect)
		error("Method not implemented.")
	end
end
return {
	TeamsScreen = TeamsScreen,
}
