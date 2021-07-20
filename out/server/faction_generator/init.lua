-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, TS.getModule(script, "@rbxts", "services")).ReplicatedStorage
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local getFactions = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions", "faction").getFactions
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local location = ReplicatedStorage:FindFirstChild("FamilyList")
local function generateFactionFolder(faction)
	local folder = Instance.new("Folder")
	folder.Name = faction.name
	local idValue = Instance.new("NumberValue")
	idValue.Name = "GroupID"
	idValue.Value = faction.groupId
	idValue.Parent = folder
	local decal = Instance.new("Decal")
	decal.Name = "Flag"
	decal.Texture = faction.emblem
	decal.Parent = folder
	return folder
end
local function generate()
	local _result = location
	if _result ~= nil then
		_result:ClearAllChildren()
	end
	local _exp = getFactions()
	local _arg0 = function(faction)
		local _exp_1 = generateFactionFolder(faction)
		_exp_1.Parent = location
		return _exp_1.Parent
	end
	-- ▼ ReadonlyMap.forEach ▼
	for _k, _v in pairs(_exp) do
		_arg0(_v, _k, _exp)
	end
	-- ▲ ReadonlyMap.forEach ▲
end
--[[
	*
	* Generates factions for the (terrible) capture points script
]]
local FactionGeneratorHandler
do
	local super = Handler
	FactionGeneratorHandler = setmetatable({}, {
		__tostring = function()
			return "FactionGeneratorHandler"
		end,
		__index = super,
	})
	FactionGeneratorHandler.__index = FactionGeneratorHandler
	function FactionGeneratorHandler.new(...)
		local self = setmetatable({}, FactionGeneratorHandler)
		return self:constructor(...) or self
	end
	function FactionGeneratorHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "Faction Generator"
	end
	function FactionGeneratorHandler:run()
		local _arg0 = t.instanceOf("Folder")(location)
		assert(_arg0, "Expected folder in ReplicatedStorage named 'FamilyList'")
		-- const bindable = script.Parent?.FindFirstChild("onjoin")?.FindFirstChild("reloadteams")
		-- if (t.instanceIsA("BindableEvent")(bindable))
		-- bindable.Event.Connect(generate);
		generate()
	end
end
return {
	FactionGeneratorHandler = FactionGeneratorHandler,
}
