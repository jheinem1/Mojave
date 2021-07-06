-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local GroupService = _0.GroupService
local Players = _0.Players
local RunService = _0.RunService
local _1 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "faction")
local ClientFaction = _1.ClientFaction
local Faction = _1.Faction
local FactionRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "faction_remotes").default
local cleanGroupName = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "utility_functions").cleanGroupName
local clientInfo = RunService:IsServer() and {} or nil
local cachingConnections
local factions
local groupId = 4978642
--[[
	*
	* Cannot be called from the client.
	* Gets a list of allied factions.
]]
local function getFactions(update)
	if RunService:IsClient() or not clientInfo then
		error("Cannot be called from the client")
	end
	if update or not factions then
		local newAllies = {}
		local allyPages = GroupService:GetAlliesAsync(4978642)
		while true do
			local _2 = allyPages:GetCurrentPage()
			local _3 = function(group)
				group.Name = cleanGroupName(group.Name)
				local _4 = newAllies
				local _5 = group
				-- ▼ Array.push ▼
				_4[#_4 + 1] = _5
				-- ▲ Array.push ▲
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _4, _5 in ipairs(_2) do
				_3(_5, _4 - 1, _2)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if allyPages.IsFinished then
				break
			else
				allyPages:AdvanceToNextPageAsync()
			end
		end
		factions = {}
		local _2 = newAllies
		local _3 = function(group)
			local _4 = factions
			local _5 = group.Id
			local _6 = Faction.new(group)
			-- ▼ Map.set ▼
			_4[_5] = _6
			-- ▲ Map.set ▲
			return _4
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _4, _5 in ipairs(_2) do
			_3(_5, _4 - 1, _2)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	return factions
end
--[[
	*
	* Used for caching player group information on the server.
	* **ONLY ACCESSIBLE FROM THE SERVER**
]]
local quitCaching
local function startCaching()
	if RunService:IsClient() or not clientInfo then
		error("Cannot be called from the client")
	end
	quitCaching()
	cachingConnections = {}
	local factionRemote = FactionRemotes.Server:Create("GetClientInfo")
	local factions = getFactions(true)
	local _2 = cachingConnections
	local _3 = Players.PlayerAdded:Connect(function(player)
		local _4 = factions
		local _5 = function(faction)
			local _6 = faction.roles
			local _7 = player:GetRankInGroup(faction.groupId)
			local role = _6[_7]
			if role then
				local _8 = faction.players
				local _9 = player
				local _10 = role
				-- ▼ Map.set ▼
				_8[_9] = _10
				-- ▲ Map.set ▲
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _6, _7 in pairs(_4) do
			_5(_7, _6, _4)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return nil
	end)
	-- ▼ Array.push ▼
	_2[#_2 + 1] = _3
	-- ▲ Array.push ▲
	local onPlayer = function(player)
		local _4 = factions
		local _5 = function(faction)
			local rank = player:GetRankInGroup(faction.groupId)
			local _6 = faction.roles
			local _7 = rank
			local role = _6[_7]
			if role then
				local _8 = faction.players
				local _9 = player
				local _10 = role
				-- ▼ Map.set ▼
				_8[_9] = _10
				-- ▲ Map.set ▲
				local _11 = clientInfo
				local _12 = player
				if not _11[_12] then
					local _13 = clientInfo
					local _14 = player
					-- ▼ Map.set ▼
					_13[_14] = {
						factions = {},
					}
					-- ▲ Map.set ▲
				end
				local roles = {}
				local _13 = faction.roles
				local _14 = function(role)
					local _15 = roles
					local _16 = {
						name = role.name,
						id = role.id,
						faction = faction.groupId,
					}
					-- ▼ Array.push ▼
					local _17 = #_15
					_15[_17 + 1] = _16
					-- ▲ Array.push ▲
					return _17 + 1
				end
				-- ▼ ReadonlyMap.forEach ▼
				for _15, _16 in pairs(_13) do
					_14(_16, _15, _13)
				end
				-- ▲ ReadonlyMap.forEach ▲
				local _15 = clientInfo
				local _16 = player
				local _17 = _15[_16]
				if _17 ~= nil then
					local _18 = _17.factions
					local _19 = {
						name = faction.name,
						shortName = faction.shortName,
						groupId = faction.groupId,
						roles = roles,
						color = faction.color,
						clientRole = rank,
					}
					-- ▼ Array.push ▼
					_18[#_18 + 1] = _19
					-- ▲ Array.push ▲
				end
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _6, _7 in pairs(_4) do
			_5(_7, _6, _4)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return nil
	end
	Players.PlayerAdded:Connect(onPlayer)
	local _4 = Players:GetPlayers()
	local _5 = onPlayer
	-- ▼ ReadonlyArray.forEach ▼
	for _6, _7 in ipairs(_4) do
		_5(_7, _6 - 1, _4)
	end
	-- ▲ ReadonlyArray.forEach ▲
	factionRemote:SetCallback(function(player)
		local _6 = clientInfo
		local _7 = player
		local _8 = _6[_7]
		if _8 == nil then
			_8 = error("Client info for player " .. tostring(player) .. " does not exist")
		end
		return _8
	end)
end
function quitCaching()
	if cachingConnections then
		local _2 = cachingConnections
		local _3 = function(connection)
			return connection:Disconnect()
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _4, _5 in ipairs(_2) do
			_3(_5, _4 - 1, _2)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end
local clientFactionInfo
local getClientFactionInfo = TS.async(function(update)
	if update or not clientFactionInfo then
		local clientData = FactionRemotes.Client:WaitFor("GetClientInfo"):andThen(function(remote)
			return remote:CallServerAsync()
		end)
		local _2 = (TS.await(clientData)).factions
		local _3 = function(factionInfo)
			return ClientFaction.new(factionInfo)
		end
		-- ▼ ReadonlyArray.map ▼
		local _4 = table.create(#_2)
		for _5, _6 in ipairs(_2) do
			_4[_5] = _3(_6, _5 - 1, _2)
		end
		-- ▲ ReadonlyArray.map ▲
		clientFactionInfo = _4
	end
	return clientFactionInfo
end)
return {
	getFactions = getFactions,
	startCaching = startCaching,
	quitCaching = quitCaching,
	getClientFactionInfo = getClientFactionInfo,
}
