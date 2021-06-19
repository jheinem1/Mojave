-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local inSafezone = Remotes.Client:Get("InSafezone")
local function safezoneElement(props)
	return Roact.createElement("ScreenGui", {
		ResetOnSpawn = false,
		Enabled = props.Visible,
	}, {
		Roact.createElement("TextLabel", {
			Text = "[SAFEZONE]",
			TextColor3 = Color3.new(1, 1, 1),
			TextStrokeTransparency = 0,
			TextScaled = true,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 0.05),
		}),
	})
end
local _0 = Roact
local _1 = safezoneElement({
	Visible = false,
})
local _2 = Players.LocalPlayer:WaitForChild("PlayerGui", 5)
if _2 == nil then
	_2 = error("PlayerGui not found for some reason???")
end
local safezoneElementHandle = _0.mount(_1, _2)
inSafezone:Connect(function(isInSafezone)
	return Roact.update(safezoneElementHandle, safezoneElement({
		Visible = isInSafezone,
	}))
end)
