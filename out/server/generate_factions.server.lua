-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ReplicatedStorage = TS.import(script, TS.getModule(script, "services")).ReplicatedStorage
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Allies = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "allies").default
local location = ReplicatedStorage:FindFirstChild("FamilyList")
local _0 = t.instanceOf("Folder")(location)
assert(_0, "Expected folder in ReplicatedStorage named 'FamilyList'")
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
	local _1 = location
	if _1 ~= nil then
		_1:ClearAllChildren()
	end
	for _, group in ipairs(Allies.allies) do
		generateFactionFolder(group).Parent = location
	end
end
local _1 = script.Parent
if _1 ~= nil then
	_1 = _1:FindFirstChild("onjoin")
	if _1 ~= nil then
		_1 = _1:FindFirstChild("reloadteams")
	end
end
local bindable = _1
if t.instanceIsA("BindableEvent")(bindable) then
	bindable.Event:Connect(generate)
end
generate()
