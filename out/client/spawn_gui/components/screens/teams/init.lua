-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Screen = TS.import(script, script.Parent, "screen").Screen
-- const buttons = new Array<Roact.Element>();
-- for (let i = 0; i < 3; i++)
-- buttons.push(<TeamButtonComponent
-- Name={tostring(i)}
-- Avatar={<AvatarViewportComponent />}
-- StartSize={0.3}
-- SelectedEvent={new ObjectEvent<[number]>()}
-- DeselectedEvent={new ObjectEvent<[number]>()}
-- />)
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
			}, {
				Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
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
		self.name = "Teams"
	end
	function TeamsScreen:getScreenComponent()
		return Roact.createElement(TeamsComponent)
	end
end
return {
	TeamsScreen = TeamsScreen,
}
