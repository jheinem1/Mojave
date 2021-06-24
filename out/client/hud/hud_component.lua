-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ActionPoints = TS.import(script, script.Parent, "ap").ActionPoints
local Caps = TS.import(script, script.Parent, "caps").Caps
local Compass = TS.import(script, script.Parent, "compass").Compass
local Health = TS.import(script, script.Parent, "health").Health
local Scope = TS.import(script, script.Parent, "scope").Scope
local Settings = TS.import(script, script.Parent, "settings").Settings
local State = TS.import(script, script.Parent, "state").State
local ToolComponent = TS.import(script, script.Parent, "tool").ToolComponent
local HudComponent
do
	HudComponent = Roact.Component:extend("HudComponent")
	function HudComponent:init()
	end
	function HudComponent:render()
		return Roact.createFragment({
			HUD = Roact.createElement("ScreenGui", {
				ResetOnSpawn = false,
			}, {
				Roact.createElement(Health),
				Roact.createElement(ToolComponent),
				Roact.createElement(ActionPoints),
				Roact.createElement(State),
				Roact.createElement(Compass),
				Roact.createElement(Scope),
				Roact.createElement(Settings),
				Roact.createElement(Caps),
			}),
		})
	end
end
return {
	HudComponent = HudComponent,
}
