-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local GroupService = _services.GroupService
local Players = _services.Players
local RunService = _services.RunService
local _faction = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "faction_manager", "faction")
local ClientFaction = _faction.ClientFaction
local Faction = _faction.Faction
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
			local _faction_1 = Faction.new(group)
			-- ▼ Map.set ▼
			_factions[_id] = _faction_1
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
						faction = faction.groupId,
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
						shortName = faction.shortName,
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
local clientFactionInfo
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
	getFactions = getFactions,
	startCaching = startCaching,
	quitCaching = quitCaching,
	getClientFactionInfo = getClientFactionInfo,
}
