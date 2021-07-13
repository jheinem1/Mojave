-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local MapPointComponent
do
	MapPointComponent = Roact.Component:extend("MapPointComponent")
	function MapPointComponent:init()
	end
	function MapPointComponent:render()
		return Roact.createFragment({
			Destination = Roact.createElement("TextButton", {
				BackgroundColor3 = self.props.controlling and self.props.controlling:map(function(faction)
					return faction.color.Color
				end) or Color3.new(0.5, 0.5, 0.5),
				BorderColor3 = Color3.fromRGB(255, 226, 86),
				BorderSizePixel = 5,
				Font = Enum.Font.SourceSans,
				Position = self.props.position:map(function(position)
					return UDim2.fromOffset(position.X, position.Y)
				end),
				Size = UDim2.new(0, 25, 0, 25),
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14,
			}),
		})
	end
end
return {
	MapPointComponent = MapPointComponent,
}
