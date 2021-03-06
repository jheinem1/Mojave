-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Debris = _services.Debris
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local RunService = _services.RunService
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local getFactions = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions", "faction").getFactions
local getTeams = TS.import(script, game:GetService("ServerScriptService"), "Server", "team_generator", "generator_funcs").getTeams
local Avatar = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar").Avatar
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local genPoints = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point_gen").genPoints
local SpawnRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "remotes").default
local SpawnCooldownManager = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "spawn_cooldown").default
local requestSpawnRemote = SpawnRemotes.Server:Create("RequestSpawn")
local pointFolder = ReplicatedStorage:FindFirstChild("Points")
local _arg0 = t.instanceOf("Folder")(pointFolder)
assert(_arg0, "Expected folder in the ReplicatedStorage named 'Points'")
local points = genPoints(pointFolder:GetChildren())
local random = Random.new()
--[[
	*
	* Works in conjunction with the Spawn Gui to spawn the player
]]
local SpawnHandler
do
	local super = Handler
	SpawnHandler = setmetatable({}, {
		__tostring = function()
			return "SpawnHandler"
		end,
		__index = super,
	})
	SpawnHandler.__index = SpawnHandler
	function SpawnHandler.new(...)
		local self = setmetatable({}, SpawnHandler)
		return self:constructor(...) or self
	end
	function SpawnHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "Spawn"
	end
	function SpawnHandler:run()
		Players.CharacterAutoLoads = false
		Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				local _result = character:FindFirstChildWhichIsA("Humanoid")
				if _result ~= nil then
					_result = _result.Died:Connect(function()
						Debris:AddItem(character, 4)
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
			-- ??? ReadonlyArray.find ???
			local _result = nil
			for _i, _v in ipairs(points) do
				if _arg0_1(_v, _i - 1, points) == true then
					_result = _v
					break
				end
			end
			-- ??? ReadonlyArray.find ???
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
			local _result_1
			if faction then
				local _exp_1 = getTeams()
				local _result_2 = faction
				if _result_2 ~= nil then
					_result_2 = _result_2.groupId
				end
				_result_1 = _exp_1[_result_2]
			else
				_result_1 = getTeams()[-1]
			end
			local team = _result_1
			SpawnCooldownManager:logSpawn(player, point.name)
			player.Team = t.instanceIsA("Team")(team) and team or nil
			TS.Promise.new(function(resolve)
				return resolve(player:LoadCharacter())
			end)
			local character = { player.CharacterAdded:Wait() }
			local _condition_1 = faction
			if _condition_1 then
				_condition_1 = faction.uniformTop
				if _condition_1 ~= 0 and _condition_1 == _condition_1 and _condition_1 then
					_condition_1 = faction.uniformBottom
				end
			end
			if _condition_1 ~= 0 and _condition_1 == _condition_1 and _condition_1 then
				Avatar:changeShirt(character[1], faction.uniformTop)
				Avatar:changePants(character[1], faction.uniformBottom)
			end
			TS.Promise.new(function(resolve)
				if not character[1].Parent then
					character[1].AncestryChanged:Wait()
				end
				RunService.Heartbeat:Wait()
				character[1]:MoveTo(spawnLocation)
				resolve()
			end)
			return { true, "" }
		end)
	end
end
return {
	SpawnHandler = SpawnHandler,
}
