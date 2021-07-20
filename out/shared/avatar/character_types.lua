-- Compiled with roblox-ts v1.2.2
local R15Mesh = {
	LeftLowerArm = "http://www.roblox.com/asset/?id=532219991",
	LeftFoot = "http://www.roblox.com/asset/?id=532220012",
	RightHand = "http://www.roblox.com/asset/?id=532219997",
	RightLowerLeg = "http://www.roblox.com/asset/?id=532220027",
	LeftUpperLeg = "http://www.roblox.com/asset/?id=532220018",
	LeftLowerLeg = "http://www.roblox.com/asset/?id=532219995",
	LowerTorso = "http://www.roblox.com/asset/?id=532219994",
	UpperTorso = "http://www.roblox.com/asset/?id=532219993",
	LeftUpperArm = "http://www.roblox.com/asset/?id=532219996",
	RightLowerArm = "http://www.roblox.com/asset/?id=532219999",
	LeftHand = "http://www.roblox.com/asset/?id=532219986",
	RightUpperArm = "http://www.roblox.com/asset/?id=532220004",
	RightUpperLeg = "http://www.roblox.com/asset/?id=532220031",
	RightFoot = "http://www.roblox.com/asset/?id=532220020",
}
local _result = script.Parent
if _result ~= nil then
	_result = _result:FindFirstChild("models")
	if _result ~= nil then
		_result = _result:FindFirstChild("R6")
	end
end
local R6Character = _result
local _result_1 = script.Parent
if _result_1 ~= nil then
	_result_1 = _result_1:FindFirstChild("models")
	if _result_1 ~= nil then
		_result_1 = _result_1:FindFirstChild("R15")
	end
end
local R15Character = _result_1
-- if (R15Character)
-- R15Mesh.forEach((meshId, key) => {
-- if (meshId) {
-- const mesh = new Instance("SpecialMesh");
-- mesh.MeshId = meshId;
-- mesh.Parent = R15Character[key];
-- }
-- });
local function getR6()
	if R6Character then
		return R6Character:Clone()
	else
		error("Rig not found!")
	end
end
local function getR15()
	if R15Character then
		return R15Character:Clone()
	else
		error("Rig not found!")
	end
end
return {
	getR6 = getR6,
	getR15 = getR15,
}
