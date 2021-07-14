-- Compiled with roblox-ts v1.1.1
local usedColors = {}
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
	local _0 = words
	local _1 = function(word)
		local _2 = (string.match(word, "%a"))
		if _2 == nil then
			_2 = ""
		end
		return _2
	end
	-- ▼ ReadonlyArray.map ▼
	local _2 = table.create(#_0)
	for _3, _4 in ipairs(_0) do
		_2[_3] = _1(_4, _3 - 1, _0)
	end
	-- ▲ ReadonlyArray.map ▲
	-- ▼ ReadonlyArray.join ▼
	local _3 = ""
	if _3 == nil then
		_3 = ", "
	end
	-- ▲ ReadonlyArray.join ▲
	local shortName = table.concat(_2, _3)
	return shortName
end
-- * removes any non-alphanumeric characters from a string
local function cleanGroupName(name)
	local outArray = {}
	local i = 1
	local _0 = name
	local _1 = i
	local _2 = i
	local char = string.sub(_0, _1, _2)
	while char ~= "" do
		local _3 = char == " " or (string.match(char, "%a"))
		if _3 ~= 0 and _3 == _3 and _3 ~= "" and _3 then
			local _4 = outArray
			local _5 = char
			-- ▼ Array.push ▼
			_4[#_4 + 1] = _5
			-- ▲ Array.push ▲
		end
		i += 1
		local _4 = name
		local _5 = i
		local _6 = i
		char = string.sub(_4, _5, _6)
	end
	-- ▼ ReadonlyArray.join ▼
	local _3 = ""
	if _3 == nil then
		_3 = ", "
	end
	-- ▲ ReadonlyArray.join ▲
	local outStr = table.concat(outArray, _3)
	local _4 = (string.match(outStr, "^%s*(%a+[%a%s]*%a+)%s*$"))
	if _4 == nil then
		_4 = (string.match(outStr, "^%s*(%a+)%s*$"))
		if _4 == nil then
			_4 = "Invalid Group Name!"
		end
	end
	return _4
end
return {
	assignColor = assignColor,
	generateShortName = generateShortName,
	cleanGroupName = cleanGroupName,
}
