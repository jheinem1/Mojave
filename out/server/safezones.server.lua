-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local RunService = _0.RunService
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Server:Create("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local safezoneFolder = Workspace:FindFirstChild("Safezones")
local _1 = safezoneFolder
assert(_1, "Expected a folder named 'Safezones' in the workspace")
local safezoneParts = safezoneFolder:GetChildren()
local _2 = validSafezoneChildren(safezoneParts)
assert(_2, "Expected children of 'Safezones' folder to be BaseParts")
local _3 = safezoneParts
local _4 = function(safezonePart)
	return RotatedRegion3.FromPart(safezonePart)
end
-- ▼ ReadonlyArray.map ▼
local _5 = table.create(#_3)
for _6, _7 in ipairs(_3) do
	_5[_6] = _4(_7, _6 - 1, _3)
end
-- ▲ ReadonlyArray.map ▲
local safezones = _5
safezoneFolder:Destroy()
RunService.Heartbeat:Connect(function()
	local _6 = Players:GetPlayers()
	local _7 = function(player)
		local _8 = player.Character
		if _8 ~= nil then
			_8 = _8:FindFirstChild("HumanoidRootPart")
		end
		local rootPart = _8
		local _9 = player.Character
		if _9 ~= nil then
			_9 = _9:FindFirstChild("Safezone")
		end
		local existingForceField = _9
		local _10
		if t.instanceOf("Part")(rootPart) then
			local _11 = safezones
			local _12 = function(savezone)
				return savezone:CastPart(rootPart)
			end
			-- ▼ ReadonlyArray.some ▼
			local _13 = false
			for _14, _15 in ipairs(_11) do
				if _12(_15, _14 - 1, _11) then
					_13 = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			_10 = _13
		else
			_10 = false
		end
		local isInSafezone = _10
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
	for _8, _9 in ipairs(_6) do
		_7(_9, _8 - 1, _6)
	end
	-- ▲ ReadonlyArray.forEach ▲
end)
