-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local GroupService = _services.GroupService
local RunService = _services.RunService
local FactionRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "faction_remotes").default
local hardCodedFactionData = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "hard_coded_data").hardCodedFactionData
local _utility_functions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "utility_functions")
local assignColor = _utility_functions.assignColor
local generateShortName = _utility_functions.generateShortName
local groupId = _utility_functions.groupId
local cleanGroupName = _utility_functions.cleanGroupName
local clientInfo = {}
local clientSpecificInfo = {}
local cachingConnections
local factions
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
		self.emblem = groupInfo.EmblemUrl
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
		local _groupId = self.groupId
		local _result = hardCodedFactionData[_groupId]
		if _result ~= nil then
			_result = _result.color
			if _result ~= nil then
				_result = _result.Name
			end
		end
		local _condition = _result
		if _condition == nil then
			_condition = tostring((string.match(groupInfo.Description, [=[Color:%s*["']([%w ]*)["']]=])))
		end
		self.color = assignColor(_condition)
		local _groupId_1 = self.groupId
		local _result_1 = hardCodedFactionData[_groupId_1]
		if _result_1 ~= nil then
			_result_1 = _result_1.shortName
		end
		local _condition_1 = _result_1
		if _condition_1 == nil then
			local _condition_2 = (string.match(groupInfo.Description, [=[ShortName:%s*["']([%a]*)["']]=]))
			if _condition_2 == nil then
				_condition_2 = self.name
			end
			_condition_1 = generateShortName(tostring(_condition_2))
		end
		self.shortName = _condition_1
		local _condition_2 = tonumber((string.match(groupInfo.Description, [=[UniformTop:%s*["']([^"']*)["']]=])))
		if _condition_2 == nil then
			local _groupId_2 = self.groupId
			local _result_2 = hardCodedFactionData[_groupId_2]
			if _result_2 ~= nil then
				_result_2 = _result_2.uniformTop
			end
			_condition_2 = _result_2
		end
		self.uniformTop = _condition_2
		local _condition_3 = tonumber((string.match(groupInfo.Description, [=[UniformBottom:%s*["']([^"']*)["']]=])))
		if _condition_3 == nil then
			local _groupId_2 = self.groupId
			local _result_2 = hardCodedFactionData[_groupId_2]
			if _result_2 ~= nil then
				_result_2 = _result_2.uniformBottom
			end
			_condition_3 = _result_2
		end
		self.uniformBottom = _condition_3
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
		return RunService:IsStudio() and true or self.players[player] ~= nil
	end
	function Faction:getRole(player)
		return RunService:IsStudio() and { next(self.roles) } or self.players[player]
	end
end
--[[
	* Gets a list of allied factions
	*  Also updates client factions
]]
local getClientInfo
local function getFactions(update)
	if update or not factions then
		local newAllies = {}
		local allyPages = GroupService:GetAlliesAsync(groupId)
		while true do
			local _exp = allyPages:GetCurrentPage()
			local _arg0 = function(group)
				group.Name = cleanGroupName(group.Name)
				-- ▼ Array.push ▼
				newAllies[#newAllies + 1] = group
				-- ▲ Array.push ▲
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _k, _v in ipairs(_exp) do
				_arg0(_v, _k - 1, _exp)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if allyPages.IsFinished then
				break
			else
				allyPages:AdvanceToNextPageAsync()
			end
		end
		factions = {}
		local _arg0 = function(group)
			local _value = (string.match(group.Description, [=[Color:%s*["']([%w ]*)["']]=]))
			if _value ~= 0 and _value == _value and _value ~= "" and _value then
				local _factions = factions
				local _id = group.Id
				local _faction = Faction.new(group)
				-- ▼ Map.set ▼
				_factions[_id] = _faction
				-- ▲ Map.set ▲
				return false
			end
			return true
		end
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _length = 0
		for _k, _v in ipairs(newAllies) do
			if _arg0(_v, _k - 1, newAllies) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		local noColor = _newValue
		local _arg0_1 = function(group)
			local _factions = factions
			local _id = group.Id
			local _faction = Faction.new(group)
			-- ▼ Map.set ▼
			_factions[_id] = _faction
			-- ▲ Map.set ▲
			return _factions
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(noColor) do
			_arg0_1(_v, _k - 1, noColor)
		end
		-- ▲ ReadonlyArray.forEach ▲
		getClientInfo(nil, true)
	end
	return factions
end
function getClientInfo(player, update)
	if update or not clientInfo then
		-- ▼ Array.clear ▼
		table.clear(clientInfo)
		-- ▲ Array.clear ▲
		local _factions = factions
		local _arg0 = function(faction)
			local roles = {}
			local _roles = faction.roles
			local _arg0_1 = function(role)
				local _arg0_2 = {
					name = role.name,
					id = role.id,
				}
				-- ▼ Array.push ▼
				local _length = #roles
				roles[_length + 1] = _arg0_2
				-- ▲ Array.push ▲
				return _length + 1
			end
			-- ▼ ReadonlyMap.forEach ▼
			for _k, _v in pairs(_roles) do
				_arg0_1(_v, _k, _roles)
			end
			-- ▲ ReadonlyMap.forEach ▲
			local _ptr = {
				name = faction.name,
			}
			local _left = "shortName"
			local _result
			if faction.shortName == generateShortName(faction.name) then
				_result = nil
			else
				_result = faction.shortName
			end
			_ptr[_left] = _result
			_ptr.groupId = faction.groupId
			_ptr.roles = roles
			_ptr.color = faction.color
			_ptr.clientRole = -1
			_ptr.uniformTop = faction.uniformTop
			_ptr.uniformBottom = faction.uniformBottom
			-- ▼ Array.push ▼
			clientInfo[#clientInfo + 1] = _ptr
			-- ▲ Array.push ▲
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _k, _v in pairs(_factions) do
			_arg0(_v, _k, _factions)
		end
		-- ▲ ReadonlyMap.forEach ▲
	end
	local _result
	if player then
		_result = clientSpecificInfo[player]
	else
		_result = nil
	end
	local existingInfo = _result
	if player and existingInfo and not update then
		return existingInfo
	elseif player then
		local _arg0 = function(clientFaction)
			clientFaction.clientRole = player:GetRankInGroup(clientFaction.groupId)
			return clientFaction
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#clientInfo)
		for _k, _v in ipairs(clientInfo) do
			_newValue[_k] = _arg0(_v, _k - 1, clientInfo)
		end
		-- ▲ ReadonlyArray.map ▲
		local info = _newValue
		-- ▼ Map.set ▼
		clientSpecificInfo[player] = info
		-- ▲ Map.set ▲
		return info
	end
	return clientInfo
end
--[[
	*
	* Used for caching player group information on the server.
	* Generally only for internal use.
]]
local quitCaching
local function startCaching()
	quitCaching()
	cachingConnections = {}
	local factionRemote = FactionRemotes.Server:Create("GetFactions")
	local factions = getFactions(true)
	local _cachingConnections = cachingConnections
	local _arg0 = Players.PlayerAdded:Connect(function(player)
		local _arg0_1 = function(faction)
			local _roles = faction.roles
			local _arg0_2 = player:GetRankInGroup(faction.groupId)
			local role = _roles[_arg0_2]
			if role then
				-- ▼ Map.set ▼
				faction.players[player] = role
				-- ▲ Map.set ▲
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _k, _v in pairs(factions) do
			_arg0_1(_v, _k, factions)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return nil
	end)
	-- ▼ Array.push ▼
	_cachingConnections[#_cachingConnections + 1] = _arg0
	-- ▲ Array.push ▲
	factionRemote:SetCallback(function(player)
		return getClientInfo(player)
	end)
end
--[[
	*
	* Stops caching player information.
	* Generally for internal use.
]]
function quitCaching()
	if cachingConnections then
		local _cachingConnections = cachingConnections
		local _arg0 = function(connection)
			return connection:Disconnect()
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_cachingConnections) do
			_arg0(_v, _k - 1, _cachingConnections)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
return {
	getFactions = getFactions,
	startCaching = startCaching,
	quitCaching = quitCaching,
	Role = Role,
	Faction = Faction,
}
