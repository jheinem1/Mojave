-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local ReplicatedStorage = _services.ReplicatedStorage
local Teams = _services.Teams
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local getFactions = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions").getFactions
local genPoints = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point_gen").genPoints
local SpawnRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "remotes").default
local SpawnCooldownManager = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "spawn_cooldown").default
local remote = SpawnRemotes.Server:Create("RequestSpawn")
local pointFolder = ReplicatedStorage:FindFirstChild("Points")
local _arg0 = t.instanceOf("Folder")(pointFolder)
assert(_arg0, "Expected folder in the ReplicatedStorage named 'Points'")
local points = genPoints(pointFolder:GetChildren())
local random = Random.new()
remote:SetCallback(function(client, spawnArgs)
	local _exp = getFactions()
	local _faction = spawnArgs.faction
	local faction = _exp[_faction]
	local _arg0_1 = function(p)
		return p.name == spawnArgs.pointName
	end
	-- ▼ ReadonlyArray.find ▼
	local _result = nil
	for _i, _v in ipairs(points) do
		if _arg0_1(_v, _i - 1, points) == true then
			_result = _v
			break
		end
	end
	-- ▲ ReadonlyArray.find ▲
	local point = _result
	-- realistically the client should never get these errors (it wouldn't fire in the first place), but just in case...
	if not point then
		return { false, "Point does not exist!" }
	end
	if not point.canSpawn or not point.spawnPoints then
		return { false, "Cannot spawn at point " .. point.name .. "!" }
	end
	local _condition = point.controllingFaction ~= -1
	if _condition then
		local _exp_1 = point.controllingFaction
		local _result_1 = faction
		if _result_1 ~= nil then
			_result_1 = _result_1.groupId
		end
		_condition = _exp_1 == _result_1
	end
	if _condition then
		return { false, "Spawn is controlled by enemy faction!" }
	end
	local _result_1 = faction
	if _result_1 ~= nil then
		_result_1 = _result_1:isInFaction(client)
	end
	if _result_1 then
		return { false, "Unable to spawn as faction " .. faction.name .. "!" }
	end
	if SpawnCooldownManager:canSpawn(client, point.name) then
		return { false, "Spawn cooldown hasn't worn off yet! " .. tostring(SpawnCooldownManager:getCooldownSecsRemaining(client, point.name)) .. " seconds remaining." }
	end
	local spawnLocation = point.spawnPoints[random:NextInteger(0, #point.spawnPoints) + 1]
	local _fn = Teams
	local _result_2 = faction
	if _result_2 ~= nil then
		_result_2 = _result_2.name
	end
	local _condition_1 = _result_2
	if _condition_1 == nil then
		_condition_1 = "Wastelanders"
	end
	local team = _fn:FindFirstChild(_condition_1)
	SpawnCooldownManager:logSpawn(client, point.name)
	client.Team = t.instanceIsA("Team")(team) and team or nil
	client:LoadCharacter()
	local character = { client.CharacterAdded:Wait() }
	character[1]:SetPrimaryPartCFrame(CFrame.new(spawnLocation))
	return { true }
end)
