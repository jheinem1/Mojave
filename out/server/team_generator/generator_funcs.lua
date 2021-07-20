-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Teams = TS.import(script, TS.getModule(script, "@rbxts", "services")).Teams
local getFactions = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions", "faction").getFactions
local teams = {}
local function generateTeams()
	print("generating teams")
	Teams:ClearAllChildren()
	-- ▼ Map.clear ▼
	table.clear(teams)
	-- ▲ Map.clear ▲
	local wastelanders = Instance.new("Team")
	wastelanders.Name = "Wastelanders"
	wastelanders.TeamColor = BrickColor.Gray()
	local wastelandersId = Instance.new("NumberValue")
	wastelandersId.Name = "ID"
	wastelandersId.Value = -1
	wastelandersId.Parent = wastelanders
	wastelanders.Parent = Teams
	-- ▼ Map.set ▼
	teams[-1] = wastelanders
	-- ▲ Map.set ▲
	local _exp = getFactions()
	local _arg0 = function(faction)
		local team = Instance.new("Team")
		team.Name = faction.name
		team.TeamColor = faction.color
		local teamId = Instance.new("NumberValue")
		teamId.Name = "ID"
		teamId.Value = faction.groupId
		teamId.Parent = team
		team.Parent = Teams
		local _groupId = faction.groupId
		-- ▼ Map.set ▼
		teams[_groupId] = team
		-- ▲ Map.set ▲
		faction.team = team
	end
	-- ▼ ReadonlyMap.forEach ▼
	for _k, _v in pairs(_exp) do
		_arg0(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
	return teams
end
local function getTeams(update)
	if update or not teams[-1] then
		return generateTeams()
	end
	return teams
end
return {
	generateTeams = generateTeams,
	getTeams = getTeams,
}
