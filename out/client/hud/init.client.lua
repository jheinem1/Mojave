-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local HudComponent = TS.import(script, script, "hud_component").HudComponent
Roact.mount(Roact.createElement(HudComponent), Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
