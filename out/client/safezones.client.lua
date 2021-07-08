-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local ReplicatedStorage = _0.ReplicatedStorage
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local _1 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "region")
local BasePartRegion = _1.BasePartRegion
local RegionUnion = _1.RegionUnion
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Client:Get("InSafezone")
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
local shielded = false
local function enteredRegion(part)
	if not shielded then
		shielded = true
		wait()
		inSafezone:SendToServer(true)
	end
end
local function onCharacter(character)
	local part = character:WaitForChild("HumanoidRootPart")
	if t.instanceIsA("Part")(part) then
		local promise = safezoneRegions:enteredRegion(part)
		local _8 = promise
		local _9 = function()
			return enteredRegion(part)
		end
		_8:andThen(_9)
		Players.LocalPlayer.CharacterRemoving:Connect(function()
			return promise:cancel()
		end)
	end
end
inSafezone:Connect(function(isInSafezone)
	if isInSafezone then
		shielded = true
	else
		shielded = false
		local _8 = Players.LocalPlayer.Character
		if _8 ~= nil then
			_8 = _8:WaitForChild("HumanoidRootPart", 5)
		end
		local root = _8
		if t.instanceIsA("Part")(root) and safezoneRegions:isInRegion(root) then
			wait(0.5)
			shielded = true
			inSafezone:SendToServer(true)
		elseif t.instanceIsA("Part")(root) then
			local promise = safezoneRegions:enteredRegion(root)
			local _9 = promise
			local _10 = function()
				return enteredRegion(root)
			end
			_9:andThen(_10)
			Players.LocalPlayer.CharacterRemoving:Connect(function()
				return promise:cancel()
			end)
		end
	end
end)
if Players.LocalPlayer.Character then
	onCharacter(Players.LocalPlayer.Character)
end
Players.LocalPlayer.CharacterAdded:Connect(onCharacter)
