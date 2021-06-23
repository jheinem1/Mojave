-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local GroupService = _0.GroupService
local ServerScriptService = _0.ServerScriptService
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
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
		local newAllies = {}
		local allyPages = GroupService:GetAlliesAsync(4978642)
		while true do
			local _1 = allyPages:GetCurrentPage()
			local _2 = function(group)
				group.Name = self:cleanGroupName(group.Name)
				local _3 = newAllies
				local _4 = group
				-- ▼ Array.push ▼
				_3[#_3 + 1] = _4
				-- ▲ Array.push ▲
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _3, _4 in ipairs(_1) do
				_2(_4, _3 - 1, _1)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if allyPages.IsFinished then
				self.allies = newAllies
				return nil
			else
				allyPages:AdvanceToNextPageAsync()
			end
		end
	end
	function Allies:cleanGroupName(name)
		local outArray = {}
		local i = 1
		local _1 = name
		local _2 = i
		local _3 = i
		local char = string.sub(_1, _2, _3)
		while char ~= "" do
			local _4 = char == " " or (string.match(char, "%a"))
			if _4 ~= 0 and _4 == _4 and _4 ~= "" and _4 then
				local _5 = outArray
				local _6 = char
				-- ▼ Array.push ▼
				_5[#_5 + 1] = _6
				-- ▲ Array.push ▲
			end
			i += 1
			local _5 = name
			local _6 = i
			local _7 = i
			char = string.sub(_5, _6, _7)
		end
		-- ▼ ReadonlyArray.join ▼
		local _4 = ""
		if _4 == nil then
			_4 = ", "
		end
		-- ▲ ReadonlyArray.join ▲
		local outStr = table.concat(outArray, _4)
		local _5 = (string.match(outStr, "^%s*(%a+[%a%s]*%a+)%s*$"))
		if _5 == nil then
			_5 = (string.match(outStr, "^%s*(%a+)%s*$"))
			if _5 == nil then
				_5 = "Invalid Group Name!"
			end
		end
		return _5
	end
	function Allies:getAllies()
		if not self.allies then
			Allies:refresh()
		end
		return self.allies
	end
end
local _1 = ServerScriptService:FindFirstChild("Server")
if _1 ~= nil then
	_1 = _1:FindFirstChild("onjoin")
	if _1 ~= nil then
		_1 = _1:FindFirstChild("reloadteams")
	end
end
local refreshEvent = _1
if t.instanceOf("BindableEvent")(refreshEvent) then
	refreshEvent.Event:Connect(function()
		return Allies:refresh()
	end)
end
local default = Allies
return {
	default = default,
}
