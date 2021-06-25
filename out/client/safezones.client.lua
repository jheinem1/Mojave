-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local ReplicatedStorage = _0.ReplicatedStorage
local RunService = _0.RunService
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Client:Get("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _1 = Workspace:FindFirstChild("Safezones")
if _1 == nil then
	_1 = ReplicatedStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _1
local _2 = safezoneFolder
assert(_2, "Expected a folder named 'Safezones' in the workspace or ReplicatedStorage")
local safezoneParts = safezoneFolder:GetChildren()
local _3 = validSafezoneChildren(safezoneParts)
assert(_3, "Expected children of 'Safezones' folder to be BaseParts")
local _4 = safezoneParts
local _5 = function(safezonePart)
	return RotatedRegion3.FromPart(safezonePart)
end
-- ▼ ReadonlyArray.map ▼
local _6 = table.create(#_4)
for _7, _8 in ipairs(_4) do
	_6[_7] = _5(_8, _7 - 1, _4)
end
-- ▲ ReadonlyArray.map ▲
local safezones = _6
local shielded = false
inSafezone:Connect(function(isInSafezone)
	if isInSafezone then
		shielded = true
	else
		shielded = false
	end
end)
RunService.Heartbeat:Connect(function()
	if not shielded then
		local _7 = Players.LocalPlayer.Character
		if _7 ~= nil then
			_7 = _7:FindFirstChild("HumanoidRootPart")
		end
		local rootPart = _7
		local _8 = t.instanceIsA("BasePart")(rootPart)
		if _8 then
			local _9 = safezones
			local _10 = function(safezone)
				return safezone:CastPart(rootPart)
			end
			-- ▼ ReadonlyArray.some ▼
			local _11 = false
			for _12, _13 in ipairs(_9) do
				if _10(_13, _12 - 1, _9) then
					_11 = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			_8 = _11
		end
		if _8 then
			inSafezone:SendToServer(true)
			shielded = true
		end
	end
end)
