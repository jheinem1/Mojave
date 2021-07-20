-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "@rbxts", "object-event"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local SpawnGuiComponent = TS.import(script, script, "components", "spawn_gui").SpawnGuiComponent
local SpawnGui
do
	SpawnGui = setmetatable({}, {
		__tostring = function()
			return "SpawnGui"
		end,
	})
	SpawnGui.__index = SpawnGui
	function SpawnGui.new(...)
		local self = setmetatable({}, SpawnGui)
		return self:constructor(...) or self
	end
	function SpawnGui:constructor()
	end
	function SpawnGui:mount()
		local screenBinding = { Roact.createBinding(0) }
		SpawnGui.spawnGuiListener = Roact.mount(Roact.createElement(SpawnGuiComponent, {
			currentScreen = screenBinding,
			finished = self.finished,
		}), Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	function SpawnGui:unmount()
		if SpawnGui.spawnGuiListener then
			Roact.unmount(SpawnGui.spawnGuiListener)
		end
	end
	SpawnGui.finished = ObjectEvent.new()
end
return {
	SpawnGui = SpawnGui,
}
