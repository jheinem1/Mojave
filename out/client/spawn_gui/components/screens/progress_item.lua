-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local ProgressItemComponent
do
	ProgressItemComponent = Roact.Component:extend("ProgressItemComponent")
	function ProgressItemComponent:init(props)
		self.state = {
			selected = props.startSelected,
		}
	end
	function ProgressItemComponent:render()
		return Roact.createFragment({
			[tostring(self.props.name)] = Roact.createElement("TextButton", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSansBold,
				LayoutOrder = self.props.position,
				Position = UDim2.new(0, 70, 0, 0),
				Size = UDim2.new(0.2, 0, 0, 36),
				Text = tostring(self.props.name),
				TextColor3 = self.props.selected:map(function(currentScreen)
					return currentScreen == self.props.position and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(172, 172, 172)
				end),
				TextScaled = true,
				TextSize = 24,
				TextWrapped = true,
				[Roact.Event.MouseButton1Click] = function()
					return self.props.updateSelection(self.props.position)
				end,
			}),
		})
	end
end
return {
	ProgressItemComponent = ProgressItemComponent,
}
