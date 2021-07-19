-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local getClientFactionInfo = TS.import(script, script.Parent.Parent.Parent, "factions").getClientFactionInfo
local SpawnRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "remotes").default
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
		self.screens = { TeamsScreen.new(0, props.currentScreen), MapScreen.new(1, props.currentScreen, function(point)
			return self:onSpawn(point)
		end) }
	end
	ProgressComponent.onSpawn = TS.async(function(self, point)
		local selectedTeamId = self.screens[1].selectedTeam
		local _exp = Players.LocalPlayer
		local _exp_1 = (TS.await(getClientFactionInfo()))
		local _arg0 = function(faction)
			return faction.groupId == selectedTeamId
		end
		-- ▼ ReadonlyArray.find ▼
		local _result = nil
		for _i, _v in ipairs(_exp_1) do
			if _arg0(_v, _i - 1, _exp_1) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		local _condition = TS.await(_result)
		if _condition == nil then
			_condition = "Wastelanders"
		end
		print(tostring(_exp) .. " has selected to spawn as " .. tostring(_condition) .. " in " .. point.name)
		local remote = TS.await(SpawnRemotes.Client:Get("RequestSpawn"))
		local _exp_2 = remote:CallServerAsync({
			pointName = point.name,
			faction = selectedTeamId,
		})
		local _arg0_1 = function(_param)
			local success = _param[1]
			local errorMsg = _param[2]
			if success then
				self.props.finished:Fire()
			else
				warn(errorMsg)
			end
		end
		_exp_2:andThen(_arg0_1)
	end)
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
