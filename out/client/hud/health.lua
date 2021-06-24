-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Username = TS.import(script, script.Parent, "username").Username
local Health
do
	Health = Roact.Component:extend("Health")
	function Health:init()
	end
	function Health:render()
		return Roact.createFragment({
			Health = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 4, 1, -46),
				Size = UDim2.new(0, 245, 0, 40),
			}, {
				Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Size = UDim2.new(0, 35, 0, 40),
					Text = "HP",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
				}, {
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(0, 35, 0, 40),
						Text = "HP",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(0, 35, 0, 40),
							Text = "HP",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				Bars = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 35, 0, 10),
					Size = UDim2.new(0, 200, 0, 10),
				}, {
					Bar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 170, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 1, -2),
						Size = UDim2.new(1, 0, 0, 2),
						ZIndex = 4,
					}, {
						Bar = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
						}, {
							Bar = Roact.createElement("Frame", {
								BackgroundColor3 = Color3.fromRGB(67, 67, 67),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 2,
							}),
						}),
					}),
					HealthBar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 170, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(0.99, 0, 1, 0),
						ZIndex = 3,
					}, {
						Bar = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
						}, {
							Bar = Roact.createElement("Frame", {
								BackgroundColor3 = Color3.fromRGB(67, 67, 67),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 2,
							}),
						}),
					}),
					RadsBar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 91, 58),
						BorderSizePixel = 0,
						Position = UDim2.new(0.9, 0, 0, 0),
						Size = UDim2.new(0.1, 0, 1, 0),
						Visible = false,
						ZIndex = 3,
					}),
					Bar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 170, 0),
						BorderSizePixel = 0,
						Position = UDim2.new(1, -2, 0, 0),
						Size = UDim2.new(0, 2, 1, 0),
						ZIndex = 4,
					}, {
						Bar = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 2,
						}, {
							Bar = Roact.createElement("Frame", {
								BackgroundColor3 = Color3.fromRGB(67, 67, 67),
								BorderSizePixel = 0,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								ZIndex = 2,
							}),
						}),
					}),
				}),
				RadsAmount = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(1, -110, 0, -26),
					Size = UDim2.new(0, 100, 0, 40),
					Text = "+1 RADS",
					TextColor3 = Color3.fromRGB(255, 0, 0),
					TextSize = 24,
					TextXAlignment = Enum.TextXAlignment.Right,
					Visible = false,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(0, 100, 0, 40),
						Text = "+1 RADS",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
						TextXAlignment = Enum.TextXAlignment.Right,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(0, 100, 0, 40),
							Text = "+1 RADS",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
							TextXAlignment = Enum.TextXAlignment.Right,
						}),
					}),
				}),
				RadIcon = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://339643706",
					ImageColor3 = Color3.fromRGB(255, 50, 23),
					Position = UDim2.new(1, 0, 0, -20),
					Size = UDim2.new(0, 40, 0, 40),
					Visible = false,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://339643706",
						ImageColor3 = Color3.fromRGB(67, 67, 67),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(0, 40, 0, 40),
					}, {
						Shadow = Roact.createElement("ImageLabel", {
							BackgroundTransparency = 1,
							Image = "rbxassetid://339643706",
							ImageColor3 = Color3.fromRGB(67, 67, 67),
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(0, 40, 0, 40),
						}),
					}),
				}),
				Roact.createElement(Username),
			}),
		})
	end
end
return {
	Health = Health,
}
