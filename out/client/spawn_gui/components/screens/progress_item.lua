-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ProgressItemComponent
do
	ProgressItemComponent = Roact.Component:extend("ProgressItemComponent")
	function ProgressItemComponent:init(props)
		self.state = {
			selected = props.StartSelected,
		}
		props.DeselectEvent:Connect(function()
			return self:setState({
				selected = false,
			})
		end)
		props.SelectEvent:Connect(function()
			return self:setState({
				selected = true,
			})
		end)
	end
	function ProgressItemComponent:render()
		return Roact.createFragment({
			[tostring(self.props.Name)] = Roact.createElement("TextButton", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSansBold,
				LayoutOrder = self.props.Position,
				Position = UDim2.new(0, 70, 0, 0),
				Size = UDim2.new(0.2, 0, 0, 36),
				Text = tostring(self.props.Name),
				TextColor3 = self.state.selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(172, 172, 172),
				TextScaled = true,
				TextSize = 24,
				TextWrapped = true,
				[Roact.Event.MouseButton1Click] = function()
					return self.props.SelectEvent:Fire()
				end,
			}),
		})
	end
end
return {
	ProgressItemComponent = ProgressItemComponent,
}
