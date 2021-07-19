-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Debris = _services.Debris
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local RunService = _services.RunService
local Teams = _services.Teams
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local getFactions = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions").getFactions
local genPoints = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point_gen").genPoints
local SpawnRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "remotes").default
local SpawnCooldownManager = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "spawn_cooldown").default
local requestSpawnRemote = SpawnRemotes.Server:Create("RequestSpawn")
local playerDiedRemote = SpawnRemotes.Server:Create("Died")
local pointFolder = ReplicatedStorage:FindFirstChild("Points")
local _arg0 = t.instanceOf("Folder")(pointFolder)
assert(_arg0, "Expected folder in the ReplicatedStorage named 'Points'")
local points = genPoints(pointFolder:GetChildren())
local random = Random.new()
Players.CharacterAutoLoads = false
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local _result = character:FindFirstChildWhichIsA("Humanoid")
		if _result ~= nil then
			_result = _result.Died:Connect(function()
				Debris:AddItem(character, 5)
				playerDiedRemote:SendToPlayer(player)
			end)
		end
	end)
end)
requestSpawnRemote:SetCallback(function(player, spawnArgs)
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
	if faction and not faction:isInFaction(player) then
		return { false, "Unable to spawn as faction " .. faction.name .. "!" }
	end
	if not SpawnCooldownManager:canSpawn(player, point.name) and not point.safezone then
		return { false, "Spawn cooldown hasn't worn off yet! " .. tostring(SpawnCooldownManager:getCooldownSecsRemaining(player, point.name)) .. " seconds remaining." }
	end
	local spawnLocation = point.spawnPoints[random:NextInteger(0, #point.spawnPoints - 1) + 1]
	local _fn = Teams
	local _result_1 = faction
	if _result_1 ~= nil then
		_result_1 = _result_1.name
	end
	local _condition_1 = _result_1
	if _condition_1 == nil then
		_condition_1 = "Wastelanders"
	end
	local team = _fn:FindFirstChild(_condition_1)
	SpawnCooldownManager:logSpawn(player, point.name)
	player.Team = t.instanceIsA("Team")(team) and team or nil
	TS.Promise.new(function(resolve)
		return resolve(player:LoadCharacter())
	end)
	local character = { player.CharacterAdded:Wait() }
	TS.Promise.new(function(resolve)
		RunService.Heartbeat:Wait();
		(character[1]:FindFirstChild("HumanoidRootPart")).CFrame = CFrame.new(spawnLocation)
		resolve()
	end)
	return { true, "" }
end)
