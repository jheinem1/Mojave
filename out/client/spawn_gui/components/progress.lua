-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local MapScreen = TS.import(script, script.Parent, "screens", "map").MapScreen
local TeamsScreen = TS.import(script, script.Parent, "screens", "teams").TeamsScreen
local ProgressComponent
do
	ProgressComponent = Roact.Component:extend("ProgressComponent")
	function ProgressComponent:init(props)
		self.screens = { TeamsScreen.new(0), MapScreen.new(1) }
		self:setState({
			currentScreen = self.screens[1].position,
		})
		self.screens[self.state.currentScreen + 1].selected:Fire()
		local _0 = self.screens
		local _1 = function(screen)
			return screen.selected:Connect(function()
				return self:onSelect(screen)
			end)
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _2, _3 in ipairs(_0) do
			_1(_3, _2 - 1, _0)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function ProgressComponent:onSelect(screen)
		self.screens[self.state.currentScreen + 1].deselected:Fire()
		self:setState({
			currentScreen = screen.position,
		})
	end
	function ProgressComponent:render()
		local items = { Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0.1, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}) }
		local _0 = self.screens
		local _1 = function(screen)
			local _2 = items
			local _3 = screen:getButtonComponent()
			-- ▼ Array.push ▼
			local _4 = #_2
			_2[_4 + 1] = _3
			-- ▲ Array.push ▲
			return _4 + 1
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _2, _3 in ipairs(_0) do
			_1(_3, _2 - 1, _0)
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
			self.screens[self.state.currentScreen + 1]:getScreenComponent(),
		})
	end
end
return {
	ProgressComponent = ProgressComponent,
}
