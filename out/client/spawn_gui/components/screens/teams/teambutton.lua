-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Workspace = TS.import(script, TS.getModule(script, "@rbxts", "services")).Workspace
local TeamButtonComponent
do
	TeamButtonComponent = Roact.Component:extend("TeamButtonComponent")
	function TeamButtonComponent:init(props)
		props.SelectedEvent:Connect(function(element, selected)
			local _fn = self
			local _ptr = {}
			local _left = "selected"
			local _result
			if element == self then
				_result = selected
			else
				_result = false
			end
			_ptr[_left] = _result
			_ptr.oneSelected = selected
			return _fn:setState(_ptr)
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
		local normalMinimizedSize = Workspace.CurrentCamera and math.ceil(Workspace.CurrentCamera.ViewportSize.X / self.props.NumButtons) or 0
		local selectedMinimizedSize = Workspace.CurrentCamera and math.ceil(Workspace.CurrentCamera.ViewportSize.X / (self.props.NumButtons + 0.5)) or 0
		local maximizedSize = math.ceil(selectedMinimizedSize * 1.5)
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
					Visible = (self.state.selected or self.state.oneSelected and selectedMinimizedSize >= 350) and true or normalMinimizedSize >= 350,
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
