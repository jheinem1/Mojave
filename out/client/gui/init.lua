-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local StarterGui = TS.import(script, TS.getModule(script, "@rbxts", "services")).StarterGui
local SpawnGui = TS.import(script, script, "spawn_gui").SpawnGui
local HUD = TS.import(script, script, "hud").HUD
local SpawnRemotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "remotes").default
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local diedRemote = SpawnRemotes.Client:Get("Died")
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
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	HUD:mount()
end)
local onDied = TS.async(function()
	TS.try(function()
		HUD:unmount()
	end, function(error) end)
	wait(4)
	onLoad()
end)
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
	end
	function GuiHandler:run()
		diedRemote:Connect(onDied)
		onLoad()
	end
end
return {
	GuiHandler = GuiHandler,
}
