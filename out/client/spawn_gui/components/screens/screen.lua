-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "object-event"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
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
			Name = self.name,
			Position = self.position,
			StartSelected = self.startSelected,
			DeselectEvent = self.deselected,
			SelectEvent = self.selected,
			[Roact.Event.Clicked] = function()
				return self.selected:Fire()
			end,
		})
	end
end
return {
	Screen = Screen,
}
