-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Point = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point").Point
local isValidPointConstructor = t.children({
	PointName = t.instanceIsA("StringValue"),
	PositionX = t.instanceIsA("NumberValue"),
	PositionY = t.instanceIsA("NumberValue"),
	CanSpawn = t.union(t.instanceIsA("BoolValue"), t.none),
})
local getValidPointConstructors = function(pointConstructors)
	local _arg0 = function(pointConstructor)
		return isValidPointConstructor(pointConstructor) and pointConstructor or nil
	end
	-- ▼ ReadonlyArray.mapFiltered ▼
	local _newValue = {}
	local _length = 0
	for _k, _v in ipairs(pointConstructors) do
		local _result = _arg0(_v, _k - 1, pointConstructors)
		if _result ~= nil then
			_length += 1
			_newValue[_length] = _result
		end
	end
	-- ▲ ReadonlyArray.mapFiltered ▲
	return _newValue
end
local function genPoints(pointConstructors)
	local _exp = getValidPointConstructors(pointConstructors)
	local _arg0 = function(pointConstructor)
		local _exp_1 = Vector2.new(pointConstructor.PositionX.Value, pointConstructor.PositionY.Value)
		local _exp_2 = pointConstructor.PointName.Value
		local _result = pointConstructor.CanSpawn
		if _result ~= nil then
			_result = _result.Value
		end
		return Point.new(_exp_1, _exp_2, _result)
	end
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#_exp)
	for _k, _v in ipairs(_exp) do
		_newValue[_k] = _arg0(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.map ▲
	return _newValue
end
local function mapBounds(points)
	local _arg0 = function(lowest, current)
		return current.position.X < lowest.position.X and current or lowest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #points == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _result = points[1]
	local _callback = _arg0
	for _i = 2, #points do
		_result = _callback(_result, points[_i], _i - 1, points)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _exp = _result.position.X
	local _arg0_1 = function(lowest, current)
		return current.position.Y < lowest.position.Y and current or lowest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #points == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _result_1 = points[1]
	local _callback_1 = _arg0_1
	for _i = 2, #points do
		_result_1 = _callback_1(_result_1, points[_i], _i - 1, points)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _exp_1 = Vector2.new(_exp, _result_1.position.Y)
	local _arg0_2 = function(highest, current)
		return current.position.X > highest.position.X and current or highest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #points == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _result_2 = points[1]
	local _callback_2 = _arg0_2
	for _i = 2, #points do
		_result_2 = _callback_2(_result_2, points[_i], _i - 1, points)
	end
	-- ▲ ReadonlyArray.reduce ▲
	local _exp_2 = _result_2.position.X
	local _arg0_3 = function(highest, current)
		return current.position.Y > highest.position.Y and current or highest
	end
	-- ▼ ReadonlyArray.reduce ▼
	if #points == 0 then
		error("Attempted to call `ReadonlyArray.reduce()` on an empty array without an initialValue.")
	end
	local _result_3 = points[1]
	local _callback_3 = _arg0_3
	for _i = 2, #points do
		_result_3 = _callback_3(_result_3, points[_i], _i - 1, points)
	end
	-- ▲ ReadonlyArray.reduce ▲
	return { _exp_1, Vector2.new(_exp_2, _result_3.position.Y) }
end
return {
	genPoints = genPoints,
	mapBounds = mapBounds,
}
