-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "@rbxts", "object-event"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local Workspace = _services.Workspace
local getClientFactionInfo = TS.import(script, script.Parent.Parent.Parent.Parent, "factions").getClientFactionInfo
local Screen = TS.import(script, script.Parent, "screen").Screen
local AvatarViewportComponent = TS.import(script, script, "avatar_viewport").AvatarViewportComponent
local TeamButtonComponent = TS.import(script, script, "teambutton").TeamButtonComponent
-- const buttons = new Array<Roact.Element>();
-- for (let i = 0; i < 3; i++)
-- buttons.push(<TeamButtonComponent
-- Name={tostring(i)}
-- Avatar={<AvatarViewportComponent />}
-- StartSize={0.3}
-- SelectedEvent={new ObjectEvent<[number]>()}
-- DeselectedEvent={new ObjectEvent<[number]>()}
-- />)
local TeamsComponent
do
	TeamsComponent = Roact.Component:extend("TeamsComponent")
	function TeamsComponent:init(props)
		self.event = ObjectEvent.new()
		self.teamSelectedEvent = ObjectEvent.new()
		local _exp = getClientFactionInfo()
		local _arg0 = function(factionInfo)
			self:setState({
				factions = factionInfo,
			})
			self.teamSelectedEvent:Connect(function(id)
				self.props.selectedTeam:Fire(id)
				self.props.currentScreen[2](self.props.currentScreen[1]:getValue() + 1)
			end)
		end
		_exp:andThen(_arg0)
		local _result = Workspace.CurrentCamera
		if _result ~= nil then
			_result = _result:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				return self:render()
			end)
		end
	end
	function TeamsComponent:render()
		local teams = {}
		local _result = self.state.factions
		if _result ~= nil then
			_result = #_result
		end
		local _condition = _result
		if _condition == nil then
			_condition = 0
		end
		local numFactions = _condition + 1
		local _result_1 = self.state.factions
		if _result_1 ~= nil then
			local _arg0 = function(faction)
				local _arg0_1 = Roact.createElement(TeamButtonComponent, {
					Name = faction.shortName,
					Id = faction.groupId,
					Avatar = Roact.createElement(AvatarViewportComponent, {
						player = Players.LocalPlayer,
						shirtId = faction.uniformTop,
						pantsId = faction.uniformBottom,
					}),
					NumButtons = numFactions,
					StartSelectedIfAlone = false,
					SelectedEvent = self.event,
					SelectionFinishedEvent = self.teamSelectedEvent,
				})
				-- ▼ Array.push ▼
				local _length = #teams
				teams[_length + 1] = _arg0_1
				-- ▲ Array.push ▲
				return _length + 1
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _k, _v in ipairs(_result_1) do
				_arg0(_v, _k - 1, _result_1)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		local _ptr = {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 36),
			Size = UDim2.new(1, 0, 1, -36),
		}
		local _ptr_1 = {
			Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Roact.createElement(TeamButtonComponent, {
				Name = "WASTELANDER",
				Id = -1,
				Avatar = Roact.createElement(AvatarViewportComponent, {
					player = Players.LocalPlayer,
					shirtId = 333020740,
					pantsId = 333020646,
				}),
				NumButtons = numFactions,
				StartSelectedIfAlone = true,
				SelectedEvent = self.event,
				SelectionFinishedEvent = self.teamSelectedEvent,
			}),
		}
		local _length = #_ptr_1
		for _k, _v in ipairs(teams) do
			_ptr_1[_length + _k] = _v
		end
		return Roact.createFragment({
			Teams = Roact.createElement("Frame", _ptr, _ptr_1),
		})
	end
end
local TeamsScreen
do
	local super = Screen
	TeamsScreen = setmetatable({}, {
		__tostring = function()
			return "TeamsScreen"
		end,
		__index = super,
	})
	TeamsScreen.__index = TeamsScreen
	function TeamsScreen.new(...)
		local self = setmetatable({}, TeamsScreen)
		return self:constructor(...) or self
	end
	function TeamsScreen:constructor(...)
		super.constructor(self, ...)
		self.name = "Teams"
		self.selectedTeam = -1
	end
	function TeamsScreen:getScreenComponent()
		local selectedTeamEvent = ObjectEvent.new()
		selectedTeamEvent:Connect(function(id)
			self.selectedTeam = id
			return self.selectedTeam
		end)
		return Roact.createElement(TeamsComponent, {
			currentScreen = self.currentScreen,
			selectedTeam = selectedTeamEvent,
		})
	end
end
return {
	TeamsScreen = TeamsScreen,
}
