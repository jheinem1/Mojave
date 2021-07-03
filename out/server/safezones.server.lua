-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local ReplicatedStorage = _0.ReplicatedStorage
local RunService = _0.RunService
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local _1 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "region")
local BasePartRegion = _1.BasePartRegion
local RegionUnion = _1.RegionUnion
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Server:Create("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _2 = Workspace:FindFirstChild("Safezones")
if _2 == nil then
	_2 = ReplicatedStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _2
local _3 = safezoneFolder
assert(_3, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage")
local safezoneParts = safezoneFolder:GetChildren()
local _4 = validSafezoneChildren(safezoneParts)
assert(_4, "Expected children of 'Safezones' folder to be BaseParts")
local _5 = safezoneParts
local _6 = function(safezonePart)
	return BasePartRegion.new(safezonePart)
end
-- ▼ ReadonlyArray.map ▼
local _7 = table.create(#_5)
for _8, _9 in ipairs(_5) do
	_7[_8] = _6(_9, _8 - 1, _5)
end
-- ▲ ReadonlyArray.map ▲
local safezoneRegions = RegionUnion.new(_7)
local shielded = setmetatable({}, {
	__mode = "k",
})
safezoneFolder.Parent = ReplicatedStorage
local function safezoneCheck(player, character)
	if character == nil then
		character = player.Character
	end
	local _8 = character
	if _8 ~= nil then
		_8 = _8.PrimaryPart
	end
	local _9 = _8
	if _9 then
		_9 = safezoneRegions:isInRegion(character.PrimaryPart)
	end
	if _9 then
		local forceField = Instance.new("ForceField")
		forceField.Visible = false
		forceField.Name = "Safezone"
		forceField.Parent = character
		local _10 = shielded
		local _11 = character
		local _12 = forceField
		-- ▼ Map.set ▼
		_10[_11] = _12
		-- ▲ Map.set ▲
		inSafezone:SendToPlayer(player, true)
		local _13 = safezoneRegions:enteredRegion(character.PrimaryPart)
		local _14 = function()
			forceField:Destroy()
			inSafezone:SendToPlayer(player, false)
		end
		_13:andThen(_14)
	else
		inSafezone:SendToPlayer(player, false)
	end
end
inSafezone:Connect(function(player, _)
	return safezoneCheck(player)
end)
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		RunService.Heartbeat:Wait()
		safezoneCheck(player, character)
	end)
end)
