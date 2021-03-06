-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local ProgressComponent = TS.import(script, script.Parent, "progress").ProgressComponent
local SpawnGuiComponent
do
	SpawnGuiComponent = Roact.Component:extend("SpawnGuiComponent")
	function SpawnGuiComponent:init()
	end
	function SpawnGuiComponent:render()
		return Roact.createFragment({
			StartMenu = Roact.createElement("ScreenGui", {
				IgnoreGuiInset = true,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				DisplayOrder = 2,
			}, {
				Background = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0),
				}, {
					Title = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.SourceSansBold,
						Position = UDim2.new(0, 70, 0, 0),
						Size = UDim2.new(0.3, 0, 0, 36),
						Text = "MOJAVE WASTELANDS",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 24,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
					}),
					Roact.createElement(ProgressComponent, {
						currentScreen = self.props.currentScreen,
						finished = self.props.finished,
					}),
				}),
			}),
		})
	end
end
return {
	SpawnGuiComponent = SpawnGuiComponent,
}
