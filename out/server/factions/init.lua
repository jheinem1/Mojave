-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local GroupService = _services.GroupService
local FactionRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "faction_remotes").default
local _utility_functions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "utility_functions")
local assignColor = _utility_functions.assignColor
local generateShortName = _utility_functions.generateShortName
local groupId = _utility_functions.groupId
local cleanGroupName = _utility_functions.cleanGroupName
local clientInfo = {}
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
-- * Gets a list of allied factions
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
			local _factions = factions
			local _id = group.Id
			local _faction = Faction.new(group)
			-- ▼ Map.set ▼
			_factions[_id] = _faction
			-- ▲ Map.set ▲
			return _factions
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(newAllies) do
			_arg0(_v, _k - 1, newAllies)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	return factions
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
	local factionRemote = FactionRemotes.Server:Create("GetClientInfo")
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
	local onPlayer = function(player)
		local _arg0_1 = function(faction)
			local rank = player:GetRankInGroup(faction.groupId)
			local role = faction.roles[rank]
			if role then
				-- ▼ Map.set ▼
				faction.players[player] = role
				-- ▲ Map.set ▲
				if not clientInfo[player] then
					-- ▼ Map.set ▼
					clientInfo[player] = {
						factions = {},
					}
					-- ▲ Map.set ▲
				end
				local roles = {}
				local _roles = faction.roles
				local _arg0_2 = function(role)
					local _arg0_3 = {
						name = role.name,
						id = role.id,
					}
					-- ▼ Array.push ▼
					local _length = #roles
					roles[_length + 1] = _arg0_3
					-- ▲ Array.push ▲
					return _length + 1
				end
				-- ▼ ReadonlyMap.forEach ▼
				for _k, _v in pairs(_roles) do
					_arg0_2(_v, _k, _roles)
				end
				-- ▲ ReadonlyMap.forEach ▲
				local _result = clientInfo[player]
				if _result ~= nil then
					local _factions = _result.factions
					local _arg0_3 = {
						name = faction.name,
						groupId = faction.groupId,
						roles = roles,
						color = faction.color,
						clientRole = rank,
					}
					-- ▼ Array.push ▼
					_factions[#_factions + 1] = _arg0_3
					-- ▲ Array.push ▲
				end
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _k, _v in pairs(factions) do
			_arg0_1(_v, _k, factions)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return nil
	end
	Players.PlayerAdded:Connect(onPlayer)
	local _exp = Players:GetPlayers()
	-- ▼ ReadonlyArray.forEach ▼
	for _k, _v in ipairs(_exp) do
		onPlayer(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.forEach ▲
	factionRemote:SetCallback(function(player)
		local _condition = clientInfo[player]
		if _condition == nil then
			_condition = error("Client info for player " .. tostring(player) .. " does not exist")
		end
		return _condition
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
