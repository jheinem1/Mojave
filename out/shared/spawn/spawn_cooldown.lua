-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local RunService = _services.RunService
--[[
	*
	* Used for managing spawn cooldowns on the client & server.
]]
local SpawnCooldownManager
do
	SpawnCooldownManager = setmetatable({}, {
		__tostring = function()
			return "SpawnCooldownManager"
		end,
	})
	SpawnCooldownManager.__index = SpawnCooldownManager
	function SpawnCooldownManager.new(...)
		local self = setmetatable({}, SpawnCooldownManager)
		return self:constructor(...) or self
	end
	function SpawnCooldownManager:constructor()
	end
	function SpawnCooldownManager:canSpawn(player, pointName)
		if RunService:IsClient() then
			return self:getCooldownSecsRemaining(player, pointName) < 0
		end
		return self:getCooldownSecsRemaining(player, pointName) <= 0
	end
	function SpawnCooldownManager:getCooldownSecsRemaining(player, pointName)
		local _lastSpawnTime = self.lastSpawnAtPoint[player]
		if _lastSpawnTime ~= nil then
			_lastSpawnTime = _lastSpawnTime[pointName]
		end
		local lastSpawnTime = _lastSpawnTime
		return lastSpawnTime ~= 0 and lastSpawnTime == lastSpawnTime and lastSpawnTime and self.spawnCooldownSecs - (os.time() - lastSpawnTime) or -1
	end
	function SpawnCooldownManager:logSpawn(player, pointName)
		local lastSpawnAtPoint = self.lastSpawnAtPoint
		local spawnLogs = lastSpawnAtPoint[player]
		if spawnLogs then
			local _spawnLogs = spawnLogs
			local _arg1 = os.time()
			-- ▼ Map.set ▼
			_spawnLogs[pointName] = _arg1
			-- ▲ Map.set ▲
		else
			spawnLogs = {
				[pointName] = os.time(),
			}
			local _spawnLogs = spawnLogs
			-- ▼ Map.set ▼
			lastSpawnAtPoint[player] = _spawnLogs
			-- ▲ Map.set ▲
			Players.PlayerRemoving:Connect(function(p)
				if p == player then
					-- ▼ Map.set ▼
					lastSpawnAtPoint[player] = nil
					-- ▲ Map.set ▲
				end
			end)
		end
	end
	SpawnCooldownManager.spawnCooldownSecs = 60
	SpawnCooldownManager.lastSpawnAtPoint = {}
end
return {
	default = SpawnCooldownManager,
}
