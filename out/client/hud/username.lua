-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local Username
do
	Username = Roact.Component:extend("Username")
	function Username:init(props)
		self.state = {
			displayName = Players.LocalPlayer.DisplayName,
		}
		Players.LocalPlayer:GetPropertyChangedSignal("DisplayName"):Connect(function()
			return self:setState({
				displayName = Players.LocalPlayer.DisplayName,
			})
		end)
	end
	function Username:render()
		local displayName = self.state.displayName
		return Roact.createFragment({
			Username = Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Font = Enum.Font.SourceSansBold,
				Position = UDim2.new(0, 0, 0, -14),
				Size = UDim2.new(0, 140, 0, 20),
				Text = displayName,
				TextColor3 = Color3.fromRGB(255, 170, 0),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				ZIndex = 2,
			}, {
				Shadow = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.SourceSansBold,
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, 0, 1, 0),
					Text = displayName,
					TextColor3 = Color3.fromRGB(67, 67, 67),
					TextScaled = true,
					TextSize = 14,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.SourceSansBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
						Text = displayName,
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Bottom,
					}),
				}),
			}),
		})
	end
end
return {
	Username = Username,
}
