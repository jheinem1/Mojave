-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, TS.getModule(script, "@rbxts", "services")).ReplicatedStorage
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Allies = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "allies").default
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local location = ReplicatedStorage:FindFirstChild("FamilyList")
local _arg0 = t.instanceOf("Folder")(location)
assert(_arg0, "Expected folder in ReplicatedStorage named 'FamilyList'")
local function generateFactionFolder(group)
	local folder = Instance.new("Folder")
	folder.Name = group.Name
	local idValue = Instance.new("NumberValue")
	idValue.Name = "GroupID"
	idValue.Value = group.Id
	idValue.Parent = folder
	local decal = Instance.new("Decal")
	decal.Name = "Flag"
	decal.Texture = group.EmblemUrl
	decal.Parent = folder
	return folder
end
local function generate()
	local _result = location
	if _result ~= nil then
		_result:ClearAllChildren()
	end
	for _, group in ipairs(Allies:getAllies()) do
		generateFactionFolder(group).Parent = location
	end
end
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
	end
	function FactionGeneratorHandler:run()
		local _bindable = script.Parent
		if _bindable ~= nil then
			_bindable = _bindable:FindFirstChild("onjoin")
			if _bindable ~= nil then
				_bindable = _bindable:FindFirstChild("reloadteams")
			end
		end
		local bindable = _bindable
		if t.instanceIsA("BindableEvent")(bindable) then
			bindable.Event:Connect(generate)
		end
		generate()
	end
end
return {
	FactionGeneratorHandler = FactionGeneratorHandler,
}
