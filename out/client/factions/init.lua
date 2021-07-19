-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
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
		return self.faction.clientRole == self
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
		self.shortName = generateShortName(factionInfo.name)
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
local clientFactionInfo
--[[
	*
	* Gets a list of the factions a client is in asynchronously
	* @param update whether or not the client's faction list should be updated (otherwise it returns a cached version)
	* @returns a list of the client's factions
]]
local getClientFactionInfo = TS.async(function(update)
	if update or not clientFactionInfo then
		local clientData = FactionRemotes.Client:WaitFor("GetClientInfo"):andThen(function(remote)
			return remote:CallServerAsync()
		end)
		local _factions = (TS.await(clientData)).factions
		local _arg0 = function(factionInfo)
			return ClientFaction.new(factionInfo)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_factions)
		for _k, _v in ipairs(_factions) do
			_newValue[_k] = _arg0(_v, _k - 1, _factions)
		end
		-- ▲ ReadonlyArray.map ▲
		clientFactionInfo = _newValue
	end
	return clientFactionInfo
end)
return {
	getClientFactionInfo = getClientFactionInfo,
	ClientFaction = ClientFaction,
}
