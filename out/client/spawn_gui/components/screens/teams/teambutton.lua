-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Workspace = TS.import(script, TS.getModule(script, "services")).Workspace
local TeamButtonComponent
do
	TeamButtonComponent = Roact.Component:extend("TeamButtonComponent")
	function TeamButtonComponent:init(props)
		props.SelectedEvent:Connect(function(element, selected)
			local _0 = self
			local _1 = {}
			local _2 = "selected"
			local _3
			if element == self then
				_3 = selected
			else
				_3 = false
			end
			_1[_2] = _3
			_1.oneSelected = selected
			return _0:setState(_1)
		end)
		if props.StartSelectedIfAlone then
			self:setState({
				selected = props.StartSelectedIfAlone,
				oneSelected = props.StartSelectedIfAlone,
			})
		else
			props.SelectedEvent:Fire(self, false)
		end
	end
	function TeamButtonComponent:render()
		local normalMinimizedSize = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize.X / self.props.NumButtons or 0
		local selectedMinimizedSize = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize.X / (self.props.NumButtons + 0.5) or 0
		local maximizedSize = selectedMinimizedSize * 1.5
		return Roact.createFragment({
			[self.props.Name] = Roact.createElement("TextButton", {
				BackgroundColor3 = self.state.selected and Color3.fromRGB(46, 46, 46) or Color3.fromRGB(23, 23, 23),
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Size = UDim2.new(0, self.state.selected and maximizedSize or self.state.oneSelected and selectedMinimizedSize or normalMinimizedSize, 1, 0),
				Text = "",
				AutoButtonColor = false,
				[Roact.Event.MouseButton1Click] = function()
					if self.state.selected then
						self.props.SelectionFinishedEvent:Fire(self.props.Id)
					else
						self.props.SelectedEvent:Fire(self, true)
					end
				end,
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
