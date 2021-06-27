-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local ReplicatedStorage = _0.ReplicatedStorage
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local ClientRegions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "regions").ClientRegions
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Server:Create("InSafezone")
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
local shielded = setmetatable({}, {
	__mode = "k",
})
safezoneFolder.Parent = ReplicatedStorage
local function isInSafezone(character)
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local _7 = t.instanceIsA("BasePart")(rootPart)
	if _7 then
		local _8 = safezones
		local _9 = function(safezone)
			return safezone:CastPart(rootPart)
		end
		-- ▼ ReadonlyArray.some ▼
		local _10 = false
		for _11, _12 in ipairs(_8) do
			if _9(_12, _11 - 1, _8) then
				_10 = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		_7 = _10
	end
	if _7 then
		return true
	end
	return false
end
inSafezone:Connect(function(player, _)
	local character = player.Character
	if character and isInSafezone(character) then
		local forceField = Instance.new("ForceField")
		forceField.Visible = false
		forceField.Name = "Safezone"
		forceField.Parent = character
		local _7 = shielded
		local _8 = character
		local _9 = forceField
		-- ▼ Map.set ▼
		_7[_8] = _9
		-- ▲ Map.set ▲
		inSafezone:SendToPlayer(player, true)
		local clientRegions = ClientRegions.new(safezones, player)
		clientRegions.leftRegion:Connect(function()
			forceField:Destroy()
			inSafezone:SendToPlayer(player, false)
			clientRegions:kill()
		end)
	else
		inSafezone:SendToPlayer(player, false)
	end
end)
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		wait()
		if isInSafezone(character) then
			local forceField = Instance.new("ForceField")
			forceField.Visible = false
			forceField.Name = "Safezone"
			forceField.Parent = character
			local _7 = shielded
			local _8 = character
			local _9 = forceField
			-- ▼ Map.set ▼
			_7[_8] = _9
			-- ▲ Map.set ▲
			inSafezone:SendToPlayer(player, true)
			local clientRegions = ClientRegions.new(safezones, player)
			clientRegions.leftRegion:Connect(function()
				forceField:Destroy()
				inSafezone:SendToPlayer(player, false)
				clientRegions:kill()
			end)
		end
	end)
end)
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
