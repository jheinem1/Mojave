-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local StarterGui = TS.import(script, TS.getModule(script, "@rbxts", "services")).StarterGui
local SpawnGui = TS.import(script, script.Parent, "spawn_gui").SpawnGui
local HUD = TS.import(script, script.Parent, "hud").HUD
TS.try(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	SpawnGui:mount()
	SpawnGui.finished:Wait()
	SpawnGui:unmount()
end, function(error)
	warn("Unable to load SpawnGui! Error: " .. tostring(error))
end)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
HUD:mount()
