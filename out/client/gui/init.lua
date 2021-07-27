-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local StarterGui = _services.StarterGui
local SpawnGui = TS.import(script, script, "spawn_gui").SpawnGui
local HUD = TS.import(script, script, "hud").HUD
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local onLoad = TS.async(function()
	TS.try(function()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
		SpawnGui:mount()
		SpawnGui.finished:Wait()
		SpawnGui:unmount()
	end, function(error)
		warn("Unable to load SpawnGui! Error: " .. tostring(error))
	end)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)
local onDied = TS.async(function()
	onLoad()
end)
--[[
	*
	* Manages Roact Gui on the client
]]
local GuiHandler
do
	local super = Handler
	GuiHandler = setmetatable({}, {
		__tostring = function()
			return "GuiHandler"
		end,
		__index = super,
	})
	GuiHandler.__index = GuiHandler
	function GuiHandler.new(...)
		local self = setmetatable({}, GuiHandler)
		return self:constructor(...) or self
	end
	function GuiHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "GUI"
	end
	function GuiHandler:run()
		Players.LocalPlayer.CharacterAdded:Connect(function(character)
			return character.AncestryChanged:Connect(function()
				if not character.Parent then
					onDied()
				end
			end)
		end)
		onLoad()
		HUD:mount()
	end
end
return {
	GuiHandler = GuiHandler,
}
