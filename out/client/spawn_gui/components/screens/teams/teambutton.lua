-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local TeamButtonComponent
do
	TeamButtonComponent = Roact.Component:extend("TeamButtonComponent")
	function TeamButtonComponent:init(props)
		self.state = {
			minSize = props.StartSize,
			selected = false,
		}
		props.SelectedEvent:Connect(function(newSize)
			return self:setState({
				minSize = newSize,
				selected = true,
			})
		end)
		props.DeselectedEvent:Connect(function(newSize)
			return self:setState({
				minSize = newSize,
				selected = false,
			})
		end)
	end
	function TeamButtonComponent:render()
		return Roact.createFragment({
			[self.props.Name] = Roact.createElement("TextButton", {
				BackgroundColor3 = self.state.selected and Color3.fromRGB(46, 46, 46) or Color3.fromRGB(23, 23, 23),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Size = UDim2.new(self.state.selected and self.state.minSize * 3 or self.state.minSize, 0, 1, 0),
				Text = "",
			}, {
				Faction = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.25, 0),
					Visible = self.state.selected,
					Font = Enum.Font.GothamSemibold,
					Text = self.props.Name,
					TextColor3 = Color3.fromRGB(255, 208, 80),
					TextScaled = true,
					ZIndex = 0,
				}),
				self.props.Avatar,
			}),
		})
	end
end
return {
	TeamButtonComponent = TeamButtonComponent,
}
