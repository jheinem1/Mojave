-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local ReplicatedStorage = _0.ReplicatedStorage
local Lighting = _0.Lighting
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local ClientRegions = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "regions").ClientRegions
local lightingRegions = ReplicatedStorage:WaitForChild("LightRegions", 5)
local _1 = lightingRegions
assert(_1, "A folder in the workspace/Replicated name 'LightRegions' is required")
local lightingRegionsParts = lightingRegions:GetChildren()
local _2 = t.array(t.instanceIsA("BasePart"))(lightingRegionsParts)
assert(_2, "Children of 'LightRegions' must be BaseParts")
local regions = ClientRegions.new(lightingRegionsParts)
regions.enteredRegion:Connect(function(_, part)
	local _3 = part
	if _3 ~= nil then
		_3 = _3:FindFirstChild("Effects")
		if _3 ~= nil then
			_3 = _3:GetChildren()
		end
	end
	local effects = _3
	local _4 = part
	if _4 ~= nil then
		_4 = _4:FindFirstChild("Properties")
		if _4 ~= nil then
			_4 = _4:GetChildren()
		end
	end
	local properties = _4
	if effects then
		Lighting:ClearAllChildren()
		local _5 = effects
		local _6 = function(v)
			local _7 = v:Clone()
			_7.Parent = Lighting
			return _7.Parent
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _7, _8 in ipairs(_5) do
			_6(_8, _7 - 1, _5)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
	if properties then
		local _5 = properties
		local _6 = function(prop)
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
		for _7, _8 in ipairs(_5) do
			_6(_8, _7 - 1, _5)
		end
		-- ▲ ReadonlyArray.forEach ▲
	end
end)
