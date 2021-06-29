-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
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
		self:constructor(...)
		return self
	end
	function SpawnGui:constructor()
	end
	function SpawnGui:mount()
		SpawnGui.spawnGuiListener = Roact.mount(Roact.createElement(SpawnGuiComponent), Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	function SpawnGui:unmount()
		if SpawnGui.spawnGuiListener then
			Roact.unmount(SpawnGui.spawnGuiListener)
		end
	end
end
return {
	SpawnGui = SpawnGui,
}
