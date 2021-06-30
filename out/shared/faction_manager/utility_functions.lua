-- Compiled with roblox-ts v1.1.1
-- const usedColors = new Array<number>();
-- const isBrickColor = t.union(t.valueOf())
-- ** NOT IMPLEMENTED */
local function assignColor(color)
	return BrickColor.new(1)
end
-- * NOT IMPLEMENTED
local function generateShortName(name)
	return name
end
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
