-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Compass
do
	Compass = Roact.Component:extend("Compass")
	function Compass:init()
	end
	function Compass:render()
		return Roact.createFragment({
			Compass = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.new(0.5, -135, 1, -54),
				Size = UDim2.new(0, 270, 0, 50),
			}, {
				Bars = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 20),
					Size = UDim2.new(1, 0, 0, 12),
				}, {
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
					Bar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 170, 0),
						BorderSizePixel = 0,
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
					Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://99753110",
						ImageColor3 = Color3.fromRGB(255, 170, 0),
						ImageTransparency = 0.7,
						Position = UDim2.new(0, 0, 0, -14),
						Rotation = 180,
						Size = UDim2.new(1, 0, 0, 24),
					}),
				}),
				Compass = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 0, 32),
					Size = UDim2.new(1, 0, 0, 20),
				}, {
					N = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Size = UDim2.new(1, 0, 1, 0),
						Text = "N",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						ZIndex = 2,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Arial,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "N",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextScaled = true,
							TextSize = 24,
							TextWrapped = true,
						}, {
							Shadow = Roact.createElement("TextLabel", {
								BackgroundTransparency = 1,
								Font = Enum.Font.Arial,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								Text = "N",
								TextColor3 = Color3.fromRGB(67, 67, 67),
								TextScaled = true,
								TextSize = 24,
								TextWrapped = true,
							}),
						}),
					}),
					W = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(-1, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "W",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						ZIndex = 2,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Arial,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "W",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextScaled = true,
							TextSize = 24,
							TextWrapped = true,
						}, {
							Shadow = Roact.createElement("TextLabel", {
								BackgroundTransparency = 1,
								Font = Enum.Font.Arial,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								Text = "W",
								TextColor3 = Color3.fromRGB(67, 67, 67),
								TextScaled = true,
								TextSize = 24,
								TextWrapped = true,
							}),
						}),
					}),
					S = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(2, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "S",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						ZIndex = 2,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Arial,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "S",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextScaled = true,
							TextSize = 24,
							TextWrapped = true,
						}, {
							Shadow = Roact.createElement("TextLabel", {
								BackgroundTransparency = 1,
								Font = Enum.Font.Arial,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								Text = "S",
								TextColor3 = Color3.fromRGB(67, 67, 67),
								TextScaled = true,
								TextSize = 24,
								TextWrapped = true,
							}),
						}),
					}),
					E = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(1, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "E",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						ZIndex = 2,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Arial,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "E",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextScaled = true,
							TextSize = 24,
							TextWrapped = true,
						}, {
							Shadow = Roact.createElement("TextLabel", {
								BackgroundTransparency = 1,
								Font = Enum.Font.Arial,
								Position = UDim2.new(0, 1, 0, 1),
								Size = UDim2.new(1, 0, 1, 0),
								Text = "E",
								TextColor3 = Color3.fromRGB(67, 67, 67),
								TextScaled = true,
								TextSize = 24,
								TextWrapped = true,
							}),
						}),
					}),
					SE = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(1.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "SE",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						Visible = false,
						ZIndex = 2,
					}),
					NE = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(0.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "NE",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						Visible = false,
						ZIndex = 2,
					}),
					SW = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(-1.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "SW",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						Visible = false,
						ZIndex = 2,
					}),
					NW = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.Arial,
						Position = UDim2.new(-0.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "NW",
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextScaled = true,
						TextSize = 24,
						TextTransparency = 0.2,
						TextWrapped = true,
						Visible = false,
						ZIndex = 2,
					}),
				}),
				Tickmark = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 63, 29),
					Position = UDim2.new(0, 10, 0, 18),
					Size = UDim2.new(0, 10, 0, 10),
					Visible = false,
					ZIndex = 3,
				}, {
					Shadow = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(67, 67, 67),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 2, 0, 2),
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 2,
					}),
				}),
			}),
		})
	end
end
return {
	Compass = Compass,
}
