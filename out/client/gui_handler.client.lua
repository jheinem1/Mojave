-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- import { StarterGui } from "@rbxts/services";
local HUD = TS.import(script, script.Parent, "hud").HUD
-- import { SpawnGui } from "./spawn_gui";
-- StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
-- SpawnGui.mount();
HUD:mount()
