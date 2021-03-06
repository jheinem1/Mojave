-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Point = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "map", "point").Point
local isValidPointConstructor = t.children({
	PointName = t.instanceIsA("StringValue"),
	Position = t.children({
		X = t.instanceIsA("NumberValue"),
		Y = t.instanceIsA("NumberValue"),
	}),
	Safezone = t.instanceIsA("BoolValue"),
	CapturePointStatus = t.instanceIsA("NumberValue"),
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
local cachedPoints
-- * generates an array of `Point` objects from an array of valid `PointConstructor` instances (see PointConsturctor type)
local function genPoints(pointConstructors, update)
	local _result
	if (cachedPoints and not update) then
		_result = cachedPoints
	else
		local _exp = getValidPointConstructors(pointConstructors)
		local _arg0 = function(pointConstructor)
			local _spawns = pointConstructor:FindFirstChild("Spawns")
			if _spawns ~= nil then
				local _exp_1 = _spawns:GetChildren()
				local _arg0_1 = function(instance)
					return t.instanceIsA("Vector3Value")(instance) and instance.Value or nil
				end
				-- ▼ ReadonlyArray.mapFiltered ▼
				local _newValue = {}
				local _length = 0
				for _k, _v in ipairs(_exp_1) do
					local _result_1 = _arg0_1(_v, _k - 1, _exp_1)
					if _result_1 ~= nil then
						_length += 1
						_newValue[_length] = _result_1
					end
				end
				-- ▲ ReadonlyArray.mapFiltered ▲
				_spawns = _newValue
			end
			local spawns = _spawns
			return Point.new(Vector2.new(pointConstructor.Position.X.Value, pointConstructor.Position.Y.Value), pointConstructor.PointName.Value, pointConstructor.Safezone.Value, pointConstructor.CapturePointStatus, spawns)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_exp)
		for _k, _v in ipairs(_exp) do
			_newValue[_k] = _arg0(_v, _k - 1, _exp)
		end
		-- ▲ ReadonlyArray.map ▲
		_result = _newValue
	end
	return _result
end
-- * determines the bounds of a map from an array of `Point` objects and returns a tuple of the upper and lower bounds
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
