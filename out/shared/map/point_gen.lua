-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local getValidPointConstructors = function(pointConstructors)
	local _0 = pointConstructors
	local _1 = t.children({
		Name = t.instanceIsA("StringValue"),
		Position = t.instanceIsA("Vector3Value"),
		CanSpawn = t.union(t.instanceIsA("BoolValue"), t.none),
	})
	-- ▼ ReadonlyArray.map ▼
	local _2 = table.create(#_0)
	for _3, _4 in ipairs(_0) do
		_2[_3] = _1(_4, _3 - 1, _0)
	end
	-- ▲ ReadonlyArray.map ▲
	return _2
end
local function genPoints(pointConstructors)
	local validPointConstructors = getValidPointConstructors(pointConstructors)
end
local function mapBounds(points)
end
return {
	genPoints = genPoints,
	mapBounds = mapBounds,
}
