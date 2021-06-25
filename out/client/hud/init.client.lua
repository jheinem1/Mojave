-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local StarterGui = _0.StarterGui
local HudComponent = TS.import(script, script, "hud_component").HudComponent
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
Roact.mount(Roact.createElement(HudComponent), Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
