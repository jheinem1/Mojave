-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Workspace = _0.Workspace
local ReplicatedStorage = _0.ReplicatedStorage
local Lighting = _0.Lighting
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local ClientRegions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "regions").ClientRegions
local _1 = Workspace:FindFirstChild("LightRegions")
if _1 == nil then
	_1 = ReplicatedStorage:FindFirstChild("LightRegions")
end
local lightingRegions = _1
local _2 = lightingRegions
assert(_2, "A folder in the workspace/Replicated name 'LightRegions' is required")
local lightingRegionsParts = lightingRegions:GetChildren()
local _3 = t.array(t.instanceIsA("BasePart"))(lightingRegionsParts)
assert(_3, "Children of 'LightRegions' must be BaseParts")
local regions = ClientRegions.new(lightingRegionsParts)
regions.enteredRegion:Connect(function(_, part)
	local _4 = part
	if _4 ~= nil then
		_4 = _4:FindFirstChild("Effects")
		if _4 ~= nil then
			_4 = _4:GetChildren()
		end
	end
	local effects = _4
	local _5 = part
	if _5 ~= nil then
		_5 = _5:FindFirstChild("Properties")
		if _5 ~= nil then
			_5 = _5:GetChildren()
		end
	end
	local properties = _5
	if effects then
		Lighting:ClearAllChildren()
		local _6 = effects
		local _7 = function(v)
			local _8 = v:Clone()
			_8.Parent = Lighting
			return _8.Parent
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _8, _9 in ipairs(_6) do
			_7(_9, _8 - 1, _6)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	if properties then
		local _6 = properties
		local _7 = function(prop)
			if t.instanceIsA("ValueBase")(prop) then
				TS.try(function()
					-- @ts-ignore
					Lighting[prop.Name] = prop.Value
				end, function()
					prop:Destroy()
				end)
			end
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _8, _9 in ipairs(_6) do
			_7(_9, _8 - 1, _6)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end)
