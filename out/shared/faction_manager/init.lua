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
	local _4 = Players:GetPlayers()
	local _5 = function(player)
		local _6 = factions
		local _7 = function(faction)
			local rank = player:GetRankInGroup(faction.groupId)
			local _8 = faction.roles
			local _9 = rank
			local role = _8[_9]
			if role then
				local _10 = faction.players
				local _11 = player
				local _12 = role
				-- ▼ Map.set ▼
				_10[_11] = _12
				-- ▲ Map.set ▲
				local _13 = clientInfo
				local _14 = player
				if not _13[_14] then
					local _15 = clientInfo
					local _16 = player
					-- ▼ Map.set ▼
					_15[_16] = {
						factions = {},
					}
					-- ▲ Map.set ▲
				end
				local roles = {}
				local _15 = faction.roles
				local _16 = function(role)
					local _17 = roles
					local _18 = {
						name = role.name,
						id = role.id,
						faction = faction.groupId,
					}
					-- ▼ Array.push ▼
					local _19 = #_17
					_17[_19 + 1] = _18
					-- ▲ Array.push ▲
					return _19 + 1
				end
				-- ▼ ReadonlyMap.forEach ▼
				for _17, _18 in pairs(_15) do
					_16(_18, _17, _15)
				end
				-- ▲ ReadonlyMap.forEach ▲
				local _17 = clientInfo
				local _18 = player
				local _19 = _17[_18]
				if _19 ~= nil then
					local _20 = _19.factions
					local _21 = {
						name = faction.name,
						shortName = faction.shortName,
						groupId = faction.groupId,
						roles = roles,
						color = faction.color,
						clientRole = rank,
					}
					-- ▼ Array.push ▼
					_20[#_20 + 1] = _21
					-- ▲ Array.push ▲
				end
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _8, _9 in pairs(_6) do
			_7(_9, _8, _6)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return nil
	end
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
