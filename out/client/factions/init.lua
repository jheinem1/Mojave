-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, TS.getModule(script, "@rbxts", "services")).RunService
local FactionRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "faction_remotes").default
local generateShortName = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "utility_functions").generateShortName
--[[
	*
	* Stores information about a role in a client's faction
]]
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
		return self.faction:getRole() == self
	end
end
--[[
	*
	* Stores information on a faction and the client's role in a faction
]]
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
		local _condition = factionInfo.shortName
		if _condition == nil then
			_condition = generateShortName(factionInfo.name)
		end
		self.shortName = _condition
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
		return RunService:IsStudio() and self.roles[math.random(0, #self.roles) + 1] or self.clientRole
	end
end
local clientFactionInfo
local clientData
local getClientData = TS.async(function()
	local _condition = clientData
	if _condition == nil then
		local _exp = (TS.await(FactionRemotes.Client:WaitFor("GetFactions"):andThen(function(remote)
			return remote:CallServerAsync()
		end)))
		local _arg0 = function(factionInfo)
			return ClientFaction.new(factionInfo)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_exp)
		for _k, _v in ipairs(_exp) do
			_newValue[_k] = _arg0(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.map ▲
		_condition = _newValue
	end
	clientData = _condition
	return clientData
end)
--[[
	*
	* Gets a list of the factions a client is in asynchronously
	* @param update whether or not the client's faction list should be updated (otherwise it returns a cached version)
	* @returns a list of the client's factions
]]
local getClientFactionInfo = TS.async(function()
	if not clientFactionInfo then
		local _exp = (TS.await(getClientData()))
		local _arg0 = function(faction)
			return faction.clientRole and faction or nil
		end
		-- ▼ ReadonlyArray.mapFiltered ▼
		local _newValue = {}
		local _length = 0
		for _k, _v in ipairs(_exp) do
			local _result = _arg0(_v, _k - 1, _exp)
			if _result ~= nil then
				_length += 1
				_newValue[_length] = _result
			end
		end
		-- ▲ ReadonlyArray.mapFiltered ▲
		clientFactionInfo = _newValue
	end
	return clientFactionInfo
end)
--[[
	*
	* Gets the list of factions in a game
]]
local getFactions = TS.async(function()
	return getClientData()
end)
return {
	getClientFactionInfo = getClientFactionInfo,
	getFactions = getFactions,
	ClientFaction = ClientFaction,
}
