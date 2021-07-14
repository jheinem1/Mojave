-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local HudComponent = TS.import(script, script, "components", "hud_component").HudComponent
local HUD
do
	HUD = setmetatable({}, {
		__tostring = function()
			return "HUD"
		end,
	})
	HUD.__index = HUD
	function HUD.new(...)
		local self = setmetatable({}, HUD)
		return self:constructor(...) or self
	end
	function HUD:constructor()
	end
	function HUD:mount()
		HUD.hudListener = Roact.mount(Roact.createElement(HudComponent), Players.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
	function HUD:unmount()
		if HUD.hudListener then
			Roact.unmount(HUD.hudListener)
		end
	end
end
return {
	HUD = HUD,
}
