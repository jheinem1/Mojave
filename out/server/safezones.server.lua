-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local RunService = _0.RunService
local ServerStorage = _0.ServerStorage
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Server:Create("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _1 = Workspace:FindFirstChild("Safezones")
if _1 == nil then
	_1 = ServerStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _1
local _2 = safezoneFolder
assert(_2, "Expected a folder named 'Safezones' in the workspace or ServerStorage")
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
safezoneFolder.Parent = ServerStorage
RunService.Heartbeat:Connect(function()
	local _7 = Players:GetPlayers()
	local _8 = function(player)
		local _9 = player.Character
		if _9 ~= nil then
			_9 = _9:FindFirstChild("HumanoidRootPart")
		end
		local rootPart = _9
		local _10 = player.Character
		if _10 ~= nil then
			_10 = _10:FindFirstChild("Safezone")
		end
		local existingForceField = _10
		local _11
		if t.instanceOf("Part")(rootPart) then
			local _12 = safezones
			local _13 = function(savezone)
				return savezone:CastPart(rootPart)
			end
			-- ▼ ReadonlyArray.some ▼
			local _14 = false
			for _15, _16 in ipairs(_12) do
				if _13(_16, _15 - 1, _12) then
					_14 = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			_11 = _14
		else
			_11 = false
		end
		local isInSafezone = _11
		if not existingForceField and rootPart and isInSafezone then
			local forceField = Instance.new("ForceField")
			forceField.Visible = false
			forceField.Name = "Safezone"
			forceField.Parent = player.Character
			inSafezone:SendToPlayer(player, true)
		elseif existingForceField and rootPart and not isInSafezone then
			existingForceField:Destroy()
			inSafezone:SendToPlayer(player, false)
		end
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _9, _10 in ipairs(_7) do
		_8(_10, _9 - 1, _7)
	end
	-- ▲ ReadonlyArray.forEach ▲
end)
