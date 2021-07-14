-- Compiled with roblox-ts v1.2.2
local function getR6()
	local _result = script.Parent
	if _result ~= nil then
		_result = _result:FindFirstChild("models")
		if _result ~= nil then
			_result = _result:FindFirstChild("R6")
		end
	end
	local character = _result
	if character then
		return character:Clone()
	else
		error("Rig not found!")
	end
end
local function getR15()
	local _result = script.Parent
	if _result ~= nil then
		_result = _result:FindFirstChild("models")
		if _result ~= nil then
			_result = _result:FindFirstChild("R15")
		end
	end
	local character = _result
	if character then
		return character:Clone()
	else
		error("Rig not found!")
	end
end
return {
	getR6 = getR6,
	getR15 = getR15,
}
