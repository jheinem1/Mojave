-- Compiled with roblox-ts v1.1.1
local function getR6()
	local _0 = script.Parent
	if _0 ~= nil then
		_0 = _0:FindFirstChild("models")
		if _0 ~= nil then
			_0 = _0:FindFirstChild("R6")
		end
	end
	local character = _0
	if character then
		return character:Clone()
	else
		error("Rig not found!")
	end
end
local function getR15()
	local _0 = script.Parent
	if _0 ~= nil then
		_0 = _0:FindFirstChild("models")
		if _0 ~= nil then
			_0 = _0:FindFirstChild("R15")
		end
	end
	local character = _0
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
