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
		local borderColor = self.props.point.safezone and Color3.fromRGB(92, 168, 255) or Color3.fromRGB(255, 226, 86)
		return Roact.createFragment({
			Destination = Roact.createElement("TextButton", {
				BackgroundColor3 = self.props.controlling and self.props.controlling:map(function(faction)
					return faction.color.Color
				end) or Color3.new(0.5, 0.5, 0.5),
				BorderColor3 = borderColor,
				BorderSizePixel = 5,
				BorderMode = Enum.BorderMode.Inset,
				Font = Enum.Font.SourceSans,
				Position = self.position,
				Size = UDim2.new(0, 30, 0, 30),
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14,
				AutoButtonColor = false,
			}, {
				Title = Roact.createElement("TextLabel", {
					Position = UDim2.new(0.5, -20, -1, 0),
					Size = UDim2.new(0, 40, 1, 0),
					BackgroundTransparency = 1,
					TextSize = 15,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextStrokeColor3 = borderColor,
					TextStrokeTransparency = 0,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextXAlignment = Enum.TextXAlignment.Center,
					Font = Enum.Font.SourceSansBold,
					Text = self.props.point.name,
				}),
			}),
		})
	end
end
return {
	MapPointComponent = MapPointComponent,
}
