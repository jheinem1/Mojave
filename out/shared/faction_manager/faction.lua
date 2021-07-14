-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local _utility_functions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "utility_functions")
local assignColor = _utility_functions.assignColor
local generateShortName = _utility_functions.generateShortName
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
		return self:constructor(...) or self
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
		return self:constructor(...) or self
	end
	function Faction:constructor(groupInfo)
		self.groupInfo = groupInfo
		self.players = {}
		self.roles = {}
		self.name = groupInfo.Name
		self.groupId = groupInfo.Id
		local _roles = groupInfo.Roles
		local _arg0 = function(roleInfo)
			return Role.new(roleInfo, self)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_roles)
		for _k, _v in ipairs(_roles) do
			_newValue[_k] = _arg0(_v, _k - 1, _roles)
		end
		-- ▲ ReadonlyArray.map ▲
		local _arg0_1 = function(role)
			local _roles_1 = self.roles
			local _id = role.id
			-- ▼ Map.set ▼
			_roles_1[_id] = role
			-- ▲ Map.set ▲
			return _roles_1
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_newValue) do
			_arg0_1(_v, _k - 1, _newValue)
		end
		-- ▲ ReadonlyArray.forEach ▲
		self.color = assignColor(tostring((string.match(groupInfo.Description, [=[Color:%s*["']([%w ]*)["']]=]))))
		local _condition = (string.match(groupInfo.Description, [=[ShortName:%s*["']([%a ]*)["']]=]))
		if _condition == nil then
			_condition = self.name
		end
		self.shortName = generateShortName(tostring(_condition))
		self.uniformTop = tonumber((string.match(groupInfo.Description, [[UniformTop:%s*["']([%d]*)["']] .. "]")))
		self.uniformBottom = tonumber((string.match(groupInfo.Description, [=[UniformBottom:%s*["']([%d]*)["']]=])))
		Players.PlayerAdded:Connect(function(player)
			return self:onPlayer(player)
		end)
		local _exp = Players:GetPlayers()
		local _arg0_2 = function(player)
			return self:onPlayer(player)
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_exp) do
			_arg0_2(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	function Faction:onPlayer(player)
		local rank = self:getRoleUncached(player)
		if rank then
			-- ▼ Map.set ▼
			self.players[player] = rank
			-- ▲ Map.set ▲
		end
	end
	function Faction:getRoleUncached(player)
		local _roles = self.roles
		local _arg0 = player:GetRankInGroup(self.groupId)
		return _roles[_arg0]
	end
	function Faction:isInFaction(player)
		return self.players[player] ~= nil
	end
	function Faction:getRole(player)
		return self.players[player]
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
		return self:constructor(...) or self
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
		return self:constructor(...) or self
	end
	function ClientFaction:constructor(factionInfo)
		self.name = factionInfo.name
		self.shortName = factionInfo.shortName
		self.groupId = factionInfo.groupId
		local _roles = factionInfo.roles
		local _arg0 = function(roleInfo)
			return ClientRole.new(roleInfo, self)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_roles)
		for _k, _v in ipairs(_roles) do
			_newValue[_k] = _arg0(_v, _k - 1, _roles)
		end
		-- ▲ ReadonlyArray.map ▲
		self.roles = _newValue
		self.color = factionInfo.color
		local _roles_1 = self.roles
		local _arg0_1 = function(role)
			return factionInfo.clientRole == role.id
		end
		-- ▼ ReadonlyArray.find ▼
		local _result = nil
		for _i, _v in ipairs(_roles_1) do
			if _arg0_1(_v, _i - 1, _roles_1) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		self.clientRole = _result
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
