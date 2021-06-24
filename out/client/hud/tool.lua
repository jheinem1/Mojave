-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Tool
do
	Tool = Roact.Component:extend("Tool")
	function Tool:init()
	end
	function Tool:render()
		return Roact.createFragment({
			Ammo = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -106, 1, -136),
				Size = UDim2.new(0, 100, 0, 80),
			}, {
				MagAmmo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 40),
					Text = "100",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 0, 40),
						Text = "100",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 0, 40),
							Text = "100",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				TotalAmmo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 40),
					Size = UDim2.new(1, 0, 0, 40),
					Text = "100",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 0, 40),
						Text = "100",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 0, 40),
							Text = "100",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				Bar = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 170, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, -34, 0.5, -1),
					Size = UDim2.new(0, 70, 0, 2),
					ZIndex = 3,
				}, {
					Bar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(67, 67, 67),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}, {
						Bar = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
						}),
					}),
				}),
				ToolName = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(0, -10, 1, 0),
					Size = UDim2.new(0, 100, 0, 10),
					Text = "Assault Rifle",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Right,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "Assault Rifle",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 18,
						TextXAlignment = Enum.TextXAlignment.Right,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "Assault Rifle",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 18,
							TextXAlignment = Enum.TextXAlignment.Right,
						}),
					}),
				}),
				FiringModeIcon = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://358920621",
					ImageColor3 = Color3.fromRGB(255, 170, 0),
					ImageRectOffset = Vector2.new(0, 156),
					ImageRectSize = Vector2.new(144, 156),
					Position = UDim2.new(0, -10, 0.5, -10),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://358920621",
						ImageColor3 = Color3.fromRGB(67, 67, 67),
						ImageRectOffset = Vector2.new(0, 156),
						ImageRectSize = Vector2.new(144, 156),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}, {
						Shadow = Roact.createElement("ImageLabel", {
							BackgroundTransparency = 1,
							Image = "rbxassetid://358920621",
							ImageColor3 = Color3.fromRGB(67, 67, 67),
							ImageRectOffset = Vector2.new(0, 156),
							ImageRectSize = Vector2.new(144, 156),
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
						}),
					}),
				}),
			}),
		})
	end
end
return {
	Tool = Tool,
}
