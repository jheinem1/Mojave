-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local TooltipComponent
do
	TooltipComponent = Roact.Component:extend("TooltipComponent")
	function TooltipComponent:init()
	end
	function TooltipComponent:render()
		return Roact.createFragment({
			Tooltip = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(126, 111, 42),
				BorderColor3 = Color3.fromRGB(255, 226, 86),
				BorderSizePixel = 3,
				Position = UDim2.new(0, 1150, 0, 550),
				Size = UDim2.new(0, 283, 0, 60),
			}, {
				DestinationInfo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.SourceSansSemibold,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					Text = "Hoover Dam\nControlling Faction: NCR",
					TextColor3 = Color3.fromRGB(255, 226, 86),
					TextSize = 32,
					TextXAlignment = Enum.TextXAlignment.Left,
				}),
				Tooltip = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(126, 111, 42),
					BorderColor3 = Color3.fromRGB(255, 226, 86),
					BorderSizePixel = 3,
					Position = UDim2.new(0, 0, 1, 3),
					Size = UDim2.new(0, 283, 0, 32),
				}, {
					SpawnButton = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.SourceSansBold,
						Position = UDim2.new(0, 5, 0, 0),
						Size = UDim2.new(1, -10, 1, 0),
						Text = "SPAWN",
						TextColor3 = Color3.fromRGB(255, 226, 86),
						TextSize = 32,
					}),
				}),
			}),
		})
	end
end
return {
	TooltipComponent = TooltipComponent,
}
