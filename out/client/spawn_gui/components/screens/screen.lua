-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "object-event"))
local Screen
do
	Screen = {}
	function Screen:constructor(position)
		self.finished = ObjectEvent.new()
		self.deselected = ObjectEvent.new()
		self.selected = ObjectEvent.new()
		self.position = position
	end
end
return {
	Screen = Screen,
}
