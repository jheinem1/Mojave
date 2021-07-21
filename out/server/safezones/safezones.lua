-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local RunService = _services.RunService
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local _region = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "region")
local BasePartRegion = _region.BasePartRegion
local RegionUnion = _region.RegionUnion
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Server:Create("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _condition = Workspace:FindFirstChild("Safezones")
if _condition == nil then
	_condition = ReplicatedStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _condition
--[[
	*
	* Responsible for managing safezones on the server
]]
local SafezonesHandler
do
	local super = Handler
	SafezonesHandler = setmetatable({}, {
		__tostring = function()
			return "SafezonesHandler"
		end,
		__index = super,
	})
	SafezonesHandler.__index = SafezonesHandler
	function SafezonesHandler.new(...)
		local self = setmetatable({}, SafezonesHandler)
		return self:constructor(...) or self
	end
	function SafezonesHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "Safezones"
	end
	function SafezonesHandler:run()
		assert(safezoneFolder, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage")
		local safezoneParts = safezoneFolder:GetChildren()
		local _arg0 = validSafezoneChildren(safezoneParts)
		assert(_arg0, "Expected children of 'Safezones' folder to be BaseParts")
		local _arg0_1 = function(safezonePart)
			return BasePartRegion:fromPart(safezonePart)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#safezoneParts)
		for _k, _v in ipairs(safezoneParts) do
			_newValue[_k] = _arg0_1(_v, _k - 1, safezoneParts)
		end
		-- ▲ ReadonlyArray.map ▲
		local safezoneRegions = RegionUnion.new(_newValue)
		local shielded = setmetatable({}, {
			__mode = "k",
		})
		safezoneFolder.Parent = ReplicatedStorage
		local function safezoneCheck(player, character)
			if character == nil then
				character = player.Character
			end
			local _result = character
			if _result ~= nil then
				_result = _result.PrimaryPart
			end
			local _condition_1 = _result
			if _condition_1 then
				_condition_1 = safezoneRegions:isInRegion(character.PrimaryPart.Position)
			end
			if _condition_1 then
				local forceField = Instance.new("ForceField")
				forceField.Visible = false
				forceField.Name = "Safezone"
				forceField.Parent = character
				-- ▼ Map.set ▼
				shielded[character] = forceField
				-- ▲ Map.set ▲
				inSafezone:SendToPlayer(player, true)
				local _exp = safezoneRegions:leftRegion(character.PrimaryPart)
				local _arg0_2 = function()
					forceField:Destroy()
					inSafezone:SendToPlayer(player, false)
				end
				_exp:andThen(_arg0_2)
			else
				inSafezone:SendToPlayer(player, false)
			end
		end
		inSafezone:Connect(function(player, _)
			return safezoneCheck(player)
		end)
		local onCharacter = function(player, character)
			RunService.Heartbeat:Wait()
			safezoneCheck(player, character)
		end
		local onPlayer = function(player)
			player.CharacterAdded:Connect(function(character)
				return onCharacter(player, character)
			end)
		end
		local _exp = Players:GetPlayers()
		-- ▼ ReadonlyArray.forEach ▼
		for _k, _v in ipairs(_exp) do
			onPlayer(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.forEach ▲
		Players.PlayerAdded:Connect(onPlayer)
	end
end
return {
	SafezonesHandler = SafezonesHandler,
}
