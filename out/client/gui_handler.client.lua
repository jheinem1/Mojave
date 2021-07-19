-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local StarterGui = _services.StarterGui
local SpawnGui = TS.import(script, script.Parent, "spawn_gui").SpawnGui
local HUD = TS.import(script, script.Parent, "hud").HUD
local function onLoad()
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
end
local function onDied()
	TS.try(function()
		HUD:unmount()
	end, function(error) end)
	wait(4)
	onLoad()
end
onLoad()
local _result = Players.LocalPlayer.Character
if _result ~= nil then
	_result = _result:FindFirstChildWhichIsA("Humanoid")
	if _result ~= nil then
		_result = _result.Died:Connect(onDied)
	end
end
Players.LocalPlayer.CharacterAdded:Connect(function(character)
	local _result_1 = character:FindFirstChildWhichIsA("Humanoid")
	if _result_1 ~= nil then
		_result_1 = _result_1.Died:Connect(onDied)
	end
	return _result_1
end)
