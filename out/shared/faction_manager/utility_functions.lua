-- Compiled with roblox-ts v1.2.2
-- const usedColors = new Array<number>();
--[[
	* returns a random color
	* NOT IMPLEMENTED
]]
local function assignColor(color)
	return BrickColor.new(1)
end
-- * extracts the first letter of every word in a string
local function generateShortName(name)
	local words = string.split(name, " ")
	local _arg0 = function(word)
		local _condition = (string.match(word, "%a"))
		if _condition == nil then
			_condition = ""
		end
		return _condition
	end
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#words)
	for _k, _v in ipairs(words) do
		_newValue[_k] = _arg0(_v, _k - 1, words)
	end
	-- ▲ ReadonlyArray.map ▲
	-- ▼ ReadonlyArray.join ▼
	local _arg0_1 = ""
	if _arg0_1 == nil then
		_arg0_1 = ", "
	end
	-- ▲ ReadonlyArray.join ▲
	local shortName = table.concat(_newValue, _arg0_1)
	return shortName
end
-- * removes any non-alphanumeric characters from a string
local function cleanGroupName(name)
	local outArray = {}
	local i = 1
	local _i = i
	local _i_1 = i
	local char = string.sub(name, _i, _i_1)
	while char ~= "" do
		local _value = char == " " or (string.match(char, "%a"))
		if _value ~= 0 and _value == _value and _value ~= "" and _value then
			local _char = char
			-- ▼ Array.push ▼
			outArray[#outArray + 1] = _char
			-- ▲ Array.push ▲
		end
		i += 1
		local _i_2 = i
		local _i_3 = i
		char = string.sub(name, _i_2, _i_3)
	end
	-- ▼ ReadonlyArray.join ▼
	local _arg0 = ""
	if _arg0 == nil then
		_arg0 = ", "
	end
	-- ▲ ReadonlyArray.join ▲
	local outStr = table.concat(outArray, _arg0)
	local _condition = (string.match(outStr, "^%s*(%a+[%a%s]*%a+)%s*$"))
	if _condition == nil then
		_condition = (string.match(outStr, "^%s*(%a+)%s*$"))
		if _condition == nil then
			_condition = "Invalid Group Name!"
		end
	end
	return _condition
end
return {
	assignColor = assignColor,
	generateShortName = generateShortName,
	cleanGroupName = cleanGroupName,
}
