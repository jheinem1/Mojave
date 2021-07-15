-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local MapScreen = TS.import(script, script.Parent, "screens", "map").MapScreen
local TeamsScreen = TS.import(script, script.Parent, "screens", "teams").TeamsScreen
local ProgressComponent
do
	ProgressComponent = Roact.Component:extend("ProgressComponent")
	function ProgressComponent:init(props)
		local valueChange = props.currentScreen[2]
		props.currentScreen[2] = function(newValue)
			valueChange(newValue)
			self:setState({})
		end
		self.screens = { TeamsScreen.new(0, props.currentScreen), MapScreen.new(1, props.currentScreen, self.props.finished) }
		self:setState({
			currentScreen = self.screens[1].position,
		})
		self.screens[self.props.currentScreen[1]:getValue() + 1].selected:Fire()
		local _screens = self.screens
		local _arg0 = function(screen)
			return screen.selected:Connect(function()
				return self:onSelect(screen)
			end)
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_screens) do
			_arg0(_v, _k - 1, _screens)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ProgressComponent:onSelect(screen)
		self.screens[self.props.currentScreen[1]:getValue() + 1].deselected:Fire()
		self.props.currentScreen[2](screen.position)
	end
	function ProgressComponent:render()
		local items = { Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0.1, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}) }
		local _screens = self.screens
		local _arg0 = function(screen)
			local _arg0_1 = screen:getButtonComponent()
			-- ▼ Array.push ▼
			local _length = #items
			items[_length + 1] = _arg0_1
			-- ▲ Array.push ▲
			return _length + 1
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_screens) do
			_arg0(_v, _k - 1, _screens)
		end
		-- ▲ ReadonlyArray.forEach ▲
		return Roact.createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
		}, {
			Roact.createElement("Frame", {
				Name = "List",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.3, 70, 0, 0),
				Size = UDim2.new(0.7, -70, 0, 36),
			}, items),
			self.screens[self.props.currentScreen[1]:getValue() + 1]:getScreenComponent(),
		})
	end
end
return {
	ProgressComponent = ProgressComponent,
}
