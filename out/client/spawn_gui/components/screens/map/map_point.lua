-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local MapPointComponent
do
	MapPointComponent = Roact.Component:extend("MapPointComponent")
	function MapPointComponent:init(props)
		print(props.point.position, props.size)
		local relPosition = Vector2.new(props.point.position.X / props.size.X, props.point.position.Y / props.size.Y)
		self.position = UDim2.fromScale(relPosition.X, relPosition.Y)
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
				Position = self.position,
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
