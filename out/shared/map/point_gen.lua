-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Point = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point").Point
local isValidPointConstructor = t.children({
	PointName = t.instanceIsA("StringValue"),
	Position = t.instanceIsA("Vector3Value"),
	CanSpawn = t.union(t.instanceIsA("BoolValue"), t.none),
})
local getValidPointConstructors = function(pointConstructors)
	local _0 = pointConstructors
	local _1 = function(pointConstructor)
		return isValidPointConstructor(pointConstructor) and pointConstructor or nil
	end
	-- ▼ ReadonlyArray.mapFiltered ▼
	local _2 = {}
	local _3 = 0
	for _4, _5 in ipairs(_0) do
		local _6 = _1(_5, _4 - 1, _0)
		if _6 ~= nil then
			_3 += 1
			_2[_3] = _6
		end
	end
	-- ▲ ReadonlyArray.mapFiltered ▲
	return _2
end
local function genPoints(pointConstructors)
	local _0 = getValidPointConstructors(pointConstructors)
	local _1 = function(pointConstructor)
		local _2 = {
			name = pointConstructor.PointName.Value,
			position = pointConstructor.Position.Value,
		}
		local _3 = "canSpawn"
		local _4 = pointConstructor.CanSpawn
		if _4 ~= nil then
			_4 = _4.Value
		end
		_2[_3] = _4
		return Point.new(_2)
	end
	-- ▼ ReadonlyArray.map ▼
	local _2 = table.create(#_0)
	for _3, _4 in ipairs(_0) do
		_2[_3] = _1(_4, _3 - 1, _0)
	end
	-- ▲ ReadonlyArray.map ▲
	return _2
end
local function mapBounds(points)
	local _0 = points
	local _1 = function(lowest, current)
		return current.x < lowest.x and current or lowest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #_0 == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _2 = _0[1]
	local _3 = _1
	for _4 = 2, #_0 do
		_2 = _3(_2, _0[_4], _4 - 1, _0)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _4 = _2.x
	local _5 = points
	local _6 = function(lowest, current)
		return current.y < lowest.y and current or lowest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #_5 == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _7 = _5[1]
	local _8 = _6
	for _9 = 2, #_5 do
		_7 = _8(_7, _5[_9], _9 - 1, _5)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _9 = Vector2.new(_4, _7.y)
	local _10 = points
	local _11 = function(highest, current)
		return current.x > highest.x and current or highest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #_10 == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _12 = _10[1]
	local _13 = _11
	for _14 = 2, #_10 do
		_12 = _13(_12, _10[_14], _14 - 1, _10)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _14 = _12.x
	local _15 = points
	local _16 = function(highest, current)
		return current.y > highest.y and current or highest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #_15 == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _17 = _15[1]
	local _18 = _16
	for _19 = 2, #_15 do
		_17 = _18(_17, _15[_19], _19 - 1, _15)
	end
	-- ▲ ReadonlyArray.reduce ▲
	return { _9, Vector2.new(_14, _17.y) }
end
return {
	genPoints = genPoints,
	mapBounds = mapBounds,
}
