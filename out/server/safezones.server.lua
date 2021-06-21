-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local RunService = _0.RunService
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezoneRemote = Remotes.Server:Create("InSafezone")
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
local rootParts = {}
local shielded = {}
safezoneFolder:Destroy()
-- RunService.Heartbeat.Connect(() => {
-- Players.GetPlayers().forEach((player) => {
-- const rootPart = player.Character?.FindFirstChild("HumanoidRootPart");
-- const existingForceField = player.Character?.FindFirstChild("Safezone");
-- const isInSafezone = t.instanceOf("Part")(rootPart) ? safezones.some((savezone) => savezone.CastPart(rootPart)) : false;
-- if (!existingForceField && rootPart && isInSafezone) {
-- const forceField = new Instance("ForceField");
-- forceField.Visible = false;
-- forceField.Name = "Safezone";
-- forceField.Parent = player.Character;
-- inSafezone.SendToPlayer(player, true);
-- } else if (existingForceField && rootPart && !isInSafezone) {
-- existingForceField.Destroy();
-- inSafezone.SendToPlayer(player, false);
-- }
-- });
-- });
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if t.instanceOf("Part")(rootPart) then
			local _6 = rootParts
			local _7 = character
			local _8 = rootPart
			-- ▼ Map.set ▼
			_6[_7] = _8
			-- ▲ Map.set ▲
		end
	end)
end)
RunService.Heartbeat:Connect(function()
	local inSafezone = {}
	for character, rootPart in pairs(rootParts) do
		local _6 = safezones
		local _7 = function(safezone)
			return safezone:CastPart(rootPart)
		end
		-- ▼ ReadonlyArray.some ▼
		local _8 = false
		for _9, _10 in ipairs(_6) do
			if _7(_10, _9 - 1, _6) then
				_8 = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		if _8 then
			local _9 = inSafezone
			local _10 = character
			-- ▼ Array.push ▼
			_9[#_9 + 1] = _10
			-- ▲ Array.push ▲
		else
			local _9 = shielded
			local _10 = character
			if _9[_10] then
				local _11 = shielded
				local _12 = character
				local _13 = _11[_12]
				if _13 ~= nil then
					_13:Destroy()
				end
				local _14 = shielded
				local _15 = character
				-- ▼ Map.delete ▼
				_14[_15] = nil
				-- ▲ Map.delete ▲
			end
		end
	end
	for _, character in ipairs(inSafezone) do
		local _6 = shielded
		local _7 = character
		if not _6[_7] then
			local forceField = Instance.new("ForceField")
			forceField.Visible = false
			forceField.Name = "Safezone"
			forceField.Parent = character
			local _8 = shielded
			local _9 = character
			local _10 = forceField
			-- ▼ Map.set ▼
			_8[_9] = _10
			-- ▲ Map.set ▲
			local player = Players:GetPlayerFromCharacter(character)
			if player then
				inSafezoneRemote:SendToPlayer(player, true)
			end
		end
	end
end)
