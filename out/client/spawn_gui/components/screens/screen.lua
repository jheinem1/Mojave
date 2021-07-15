-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "@rbxts", "object-event"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local ProgressItemComponent = TS.import(script, script.Parent, "progress_item").ProgressItemComponent
local Screen
do
	Screen = {}
	function Screen:constructor(position, currentScreen)
		self.position = position
		self.currentScreen = currentScreen
		self.finished = ObjectEvent.new()
		self.deselected = ObjectEvent.new()
		self.selected = ObjectEvent.new()
		self.startSelected = position == 0
	end
	function Screen:getButtonComponent()
		return Roact.createElement(ProgressItemComponent, {
			name = self.name,
			position = self.position,
			startSelected = self.startSelected,
			deselectEvent = self.deselected,
			selected = self.currentScreen[1],
			updateSelection = self.currentScreen[2],
		})
	end
end
return {
	Screen = Screen,
}
