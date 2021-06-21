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
				local _2 = Allies.allies
				local _3 = group
				-- ▼ Array.push ▼
				local _4 = #_2
				_2[_4 + 1] = _3
				-- ▲ Array.push ▲
				return _4 + 1
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
end
Allies:refresh()
local default = Allies
return {
	default = default,
}
