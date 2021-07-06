-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "object-event"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local getClientFactionInfo = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager").getClientFactionInfo
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
		local _0 = getClientFactionInfo()
		local _1 = function(factionInfo)
			self:setState({
				factions = factionInfo,
			})
			self.teamSelectedEvent:Connect(function(id)
				local _2
				if id == -1 then
					_2 = "Wastelanders"
				else
					local _3 = factionInfo
					local _4 = function(faction)
						return faction.groupId == id
					end
					-- ▼ ReadonlyArray.find ▼
					local _5 = nil
					for _6, _7 in ipairs(_3) do
						if _4(_7, _6 - 1, _3) == true then
							_5 = _7
							break
						end
					end
					-- ▲ ReadonlyArray.find ▲
					local _6 = _5
					if _6 ~= nil then
						_6 = _6.name
					end
					_2 = _6
				end
				return print("The client has selected to spawn as the " .. tostring(_2) .. " (id:" .. tostring(id) .. ")")
			end)
		end
		_0:andThen(_1)
	end
	function TeamsComponent:render()
		local teams = {}
		local _0 = self.state.factions
		if _0 ~= nil then
			_0 = #_0
		end
		local _1 = _0
		if _1 == nil then
			_1 = 0
		end
		local numFactions = _1 + 1
		local avatarViewport = Roact.createElement(AvatarViewportComponent, {
			player = Players.LocalPlayer,
		})
		local _2 = self.state.factions
		if _2 ~= nil then
			local _3 = function(faction)
				local _4 = teams
				local _5 = Roact.createElement(TeamButtonComponent, {
					Name = faction.shortName,
					Id = faction.groupId,
					Avatar = avatarViewport,
					NumButtons = numFactions,
					StartSelectedIfAlone = false,
					SelectedEvent = self.event,
					SelectionFinishedEvent = self.teamSelectedEvent,
				})
				-- ▼ Array.push ▼
				local _6 = #_4
				_4[_6 + 1] = _5
				-- ▲ Array.push ▲
				return _6 + 1
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _4, _5 in ipairs(_2) do
				_3(_5, _4 - 1, _2)
			end
			-- ▲ ReadonlyArray.forEach ▲
		end
		local _3 = {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 36),
			Size = UDim2.new(1, 0, 1, -36),
		}
		local _4 = {
			Roact.createElement("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			Roact.createElement(TeamButtonComponent, {
				Name = "WASTELANDER",
				Id = -1,
				Avatar = avatarViewport,
				NumButtons = numFactions,
				StartSelectedIfAlone = true,
				SelectedEvent = self.event,
				SelectionFinishedEvent = self.teamSelectedEvent,
			}),
		}
		local _5 = #_4
		for _6, _7 in ipairs(teams) do
			_4[_5 + _6] = _7
		end
		return Roact.createFragment({
			Teams = Roact.createElement("Frame", _3, _4),
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
		self:constructor(...)
		return self
	end
	function TeamsScreen:constructor(...)
		super.constructor(self, ...)
		self.name = "Teams"
	end
	function TeamsScreen:getScreenComponent()
		return Roact.createElement(TeamsComponent)
	end
end
return {
	TeamsScreen = TeamsScreen,
}
