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
		local normalMinimizedSize = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize.X / self.props.NumButtons or 0
		local selectedMinimizedSize = Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize.X / (self.props.NumButtons + 0.5) or 0
		local maximizedSize = selectedMinimizedSize * 1.5
		local _ptr = {
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
		}
		local _ptr_1 = {}
		local _length = #_ptr_1
		local _ptr_2 = {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0.25, 0),
		}
		local _result
		if self.state.selected or self.state.oneSelected then
			_result = selectedMinimizedSize >= 350
		else
			_result = normalMinimizedSize >= 350
		end
		_ptr_2.Visible = _result
		_ptr_2.Font = Enum.Font.GothamSemibold
		_ptr_2.Text = self.props.Name
		_ptr_2.TextColor3 = Color3.fromRGB(255, 208, 80)
		_ptr_2.TextScaled = true
		_ptr_2.ZIndex = 0
		_ptr_1.Faction = Roact.createElement("TextLabel", _ptr_2)
		_ptr_1[_length + 1] = self.props.Avatar
		return Roact.createFragment({
			[self.props.Name] = Roact.createElement("TextButton", _ptr, _ptr_1),
		})
	end
end
return {
	TeamButtonComponent = TeamButtonComponent,
}
