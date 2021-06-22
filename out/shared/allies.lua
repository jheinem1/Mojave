-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local GroupService = TS.import(script, TS.getModule(script, "services")).GroupService
-- interface Group {
-- Name: string;
-- Id: number;
-- Owner: User;
-- EmblemUrl: string;
-- Description: string;
-- Roles: Role[];
-- }
-- interface Role {
-- Name: string;
-- Rank: number;
-- }
-- interface User {
-- Name: string;
-- Id: number;
-- }
local Allies
do
	Allies = setmetatable({}, {
		__tostring = function()
			return "Allies"
		end,
	})
	Allies.__index = Allies
	function Allies.new(...)
		local self = setmetatable({}, Allies)
		self:constructor(...)
		return self
	end
	function Allies:constructor()
	end
	function Allies:refresh()
		Allies.allies = {}
		local allyPages = GroupService:GetAlliesAsync(4978642)
		while true do
			local _0 = allyPages:GetCurrentPage()
			local _1 = function(group)
				group.Name = self:cleanGroupName(group.Name)
				local _2 = Allies.allies
				local _3 = group
				-- ▼ Array.push ▼
				_2[#_2 + 1] = _3
				-- ▲ Array.push ▲
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _2, _3 in ipairs(_0) do
				_1(_3, _2 - 1, _0)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if allyPages.IsFinished then
				return Allies.allies
			else
				allyPages:AdvanceToNextPageAsync()
			end
		end
	end
	function Allies:cleanGroupName(name)
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
		print(outStr)
		local _4 = tostring((string.match(outStr, "^%s*(%a+[%a%s]*%a+)%s*$")))
		if _4 == nil then
			_4 = tostring((string.match(outStr, "^%s*(%a+)%s*$")))
			if _4 == nil then
				_4 = "Invalid Group Name!"
			end
		end
		return _4
	end
end
Allies:refresh()
local default = Allies
return {
	default = default,
}
