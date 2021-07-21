-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local ReplicatedStorage = _services.ReplicatedStorage
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local _region = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "region")
local BasePartRegion = _region.BasePartRegion
local RegionUnion = _region.RegionUnion
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Client:Get("InSafezone")
local validSafezoneChildren = t.array(t.instanceIsA("BasePart"))
local _condition = Workspace:FindFirstChild("Safezones")
if _condition == nil then
	_condition = ReplicatedStorage:FindFirstChild("Safezones")
end
local safezoneFolder = _condition
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
		local _arg0_2 = function()
			return enteredRegion(part)
		end
		promise:andThen(_arg0_2)
		Players.LocalPlayer.CharacterRemoving:Connect(function()
			return promise:cancel()
		end)
	end
end
--[[
	*
	* Manages safezones on the client
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
		inSafezone:Connect(function(isInSafezone)
			if isInSafezone then
				shielded = true
			else
				shielded = false
				local _root = Players.LocalPlayer.Character
				if _root ~= nil then
					_root = _root:WaitForChild("HumanoidRootPart", 5)
				end
				local root = _root
				if t.instanceIsA("Part")(root) and safezoneRegions:isInRegion(root.Position) then
					wait(0.5)
					shielded = true
					inSafezone:SendToServer(true)
				elseif t.instanceIsA("Part")(root) then
					local promise = safezoneRegions:enteredRegion(root)
					local _arg0_2 = function()
						return enteredRegion(root)
					end
					promise:andThen(_arg0_2)
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
	end
end
return {
	SafezonesHandler = SafezonesHandler,
}
