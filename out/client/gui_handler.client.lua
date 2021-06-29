-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local StarterGui = TS.import(script, TS.getModule(script, "services")).StarterGui
local SpawnGui = TS.import(script, script.Parent, "spawn_gui").SpawnGui
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
SpawnGui:mount()
-- HUD.mount();
