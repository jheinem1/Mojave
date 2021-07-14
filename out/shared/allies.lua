-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local GroupService = _services.GroupService
local ServerScriptService = _services.ServerScriptService
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
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
		return self:constructor(...) or self
	end
	function Allies:constructor()
	end
	function Allies:refresh()
		local newAllies = {}
		local allyPages = GroupService:GetAlliesAsync(4978642)
		while true do
			local _exp = allyPages:GetCurrentPage()
			local _arg0 = function(group)
				group.Name = self:cleanGroupName(group.Name)
				-- ▼ Array.push ▼
				newAllies[#newAllies + 1] = group
				-- ▲ Array.push ▲
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _k, _v in ipairs(_exp) do
				_arg0(_v, _k - 1, _exp)
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
	function Allies:getAllies()
		if not self.allies then
			Allies:refresh()
		end
		return self.allies
	end
end
local _refreshEvent = ServerScriptService:FindFirstChild("Server")
if _refreshEvent ~= nil then
	_refreshEvent = _refreshEvent:FindFirstChild("onjoin")
	if _refreshEvent ~= nil then
		_refreshEvent = _refreshEvent:FindFirstChild("reloadteams")
	end
end
local refreshEvent = _refreshEvent
if t.instanceOf("BindableEvent")(refreshEvent) then
	refreshEvent.Event:Connect(function()
		return Allies:refresh()
	end)
end
local default = Allies
return {
	default = default,
}
