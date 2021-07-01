-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "services")).Players
local _0 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "utility_functions")
local assignColor = _0.assignColor
local generateShortName = _0.generateShortName
--[[
	*
	* Stores information on factions and provides speedy alternatives to existing player/groupservice methods
]]
local Role
do
	Role = setmetatable({}, {
		__tostring = function()
			return "Role"
		end,
	})
	Role.__index = Role
	function Role.new(...)
		local self = setmetatable({}, Role)
		self:constructor(...)
		return self
	end
	function Role:constructor(roleInfo, faction)
		self.faction = faction
		self.name = roleInfo.Name
		self.id = roleInfo.Rank
	end
	function Role:hasRole(player)
		return self.faction:getRole(player) == self
	end
end
--[[
	*
	* Stores information on factions and provides speedy alternatives to existing player/groupservice methods
]]
local Faction
do
	Faction = setmetatable({}, {
		__tostring = function()
			return "Faction"
		end,
	})
	Faction.__index = Faction
	function Faction.new(...)
		local self = setmetatable({}, Faction)
		self:constructor(...)
		return self
	end
	function Faction:constructor(groupInfo)
		self.groupInfo = groupInfo
		self.players = {}
		self.roles = {}
		self.name = groupInfo.Name
		self.groupId = groupInfo.Id
		local _1 = groupInfo.Roles
		local _2 = function(roleInfo)
			return Role.new(roleInfo, self)
		end
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		local _4 = function(role)
			local _5 = self.roles
			local _6 = role.id
			local _7 = role
			-- ▼ Map.set ▼
			_5[_6] = _7
			-- ▲ Map.set ▲
			return _5
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _5, _6 in ipairs(_3) do
			_4(_6, _5 - 1, _3)
		end
		-- ▲ ReadonlyArray.forEach ▲
		-- seems stupid but roblox-ts has an issue (https://github.com/roblox-ts/roblox-ts/issues/1467)
		self.color = assignColor(tostring((string.match(groupInfo.Description, [[Color:%s*["']([%w ]*)["']] .. "]"))))
		local _5 = (string.match(groupInfo.Description, [[ShortName:%s*["']([%a ]*)["']] .. "]"))
		if _5 == nil then
			_5 = self.name
		end
		self.shortName = generateShortName(tostring(_5))
		self.uniformTop = tonumber((string.match(groupInfo.Description, [[UniformTop:%s*["']([%d]*)["']] .. "]")))
		self.uniformBottom = tonumber((string.match(groupInfo.Description, [[UniformBottom:%s*["']([%d]*)["']] .. "]")))
		Players.PlayerAdded:Connect(function(player)
			return self:onPlayer(player)
		end)
		local _6 = Players:GetPlayers()
		local _7 = function(player)
			return self:onPlayer(player)
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _8, _9 in ipairs(_6) do
			_7(_9, _8 - 1, _6)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Faction:onPlayer(player)
		local rank = self:getRoleUncached(player)
		if rank then
			local _1 = self.players
			local _2 = player
			local _3 = rank
			-- ▼ Map.set ▼
			_1[_2] = _3
			-- ▲ Map.set ▲
		end
	end
	function Faction:getRoleUncached(player)
		local _1 = self.roles
		local _2 = player:GetRankInGroup(self.groupId)
		return _1[_2]
	end
	function Faction:isInFaction(player)
		local _1 = self.players
		local _2 = player
		return _1[_2] ~= nil
	end
	function Faction:getRole(player)
		local _1 = self.players
		local _2 = player
		return _1[_2]
	end
end
local ClientRole
do
	ClientRole = setmetatable({}, {
		__tostring = function()
			return "ClientRole"
		end,
	})
	ClientRole.__index = ClientRole
	function ClientRole.new(...)
		local self = setmetatable({}, ClientRole)
		self:constructor(...)
		return self
	end
	function ClientRole:constructor(roleInfo, faction)
		self.name = roleInfo.name
		self.id = roleInfo.id
		self.faction = faction
	end
	function ClientRole:hasRole()
		return self.faction.clientRole == self
	end
end
local ClientFaction
do
	ClientFaction = setmetatable({}, {
		__tostring = function()
			return "ClientFaction"
		end,
	})
	ClientFaction.__index = ClientFaction
	function ClientFaction.new(...)
		local self = setmetatable({}, ClientFaction)
		self:constructor(...)
		return self
	end
	function ClientFaction:constructor(factionInfo)
		self.name = factionInfo.name
		self.shortName = factionInfo.shortName
		self.groupId = factionInfo.groupId
		local _1 = factionInfo.roles
		local _2 = function(roleInfo)
			return ClientRole.new(roleInfo, self)
		end
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		self.roles = _3
		self.color = factionInfo.color
		local _4 = self.roles
		local _5 = function(role)
			return factionInfo.clientRole == role.id
		end
		-- ▼ ReadonlyArray.find ▼
		local _6 = nil
		for _7, _8 in ipairs(_4) do
			if _5(_8, _7 - 1, _4) == true then
				_6 = _8
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		self.clientRole = _6
		self.uniformTop = factionInfo.uniformTop
		self.uniformBottom = factionInfo.uniformBottom
	end
	function ClientFaction:getRole()
		return self.clientRole
	end
end
return {
	Role = Role,
	Faction = Faction,
	ClientFaction = ClientFaction,
}
