-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ActionPoints
do
	ActionPoints = Roact.Component:extend("ActionPoints")
	function ActionPoints:init()
	end
	function ActionPoints:render()
		return Roact.createFragment({
			ActionPoints = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -240, 1, -46),
				Size = UDim2.new(0, 235, 0, 40),
			}, {
				Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(1, -35, 0, 0),
					Size = UDim2.new(0, 35, 0, 40),
					Text = "AP",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
				}, {
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(0, 35, 0, 40),
						Text = "AP",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(0, 35, 0, 40),
							Text = "AP",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				Bars = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 10),
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
					ActionBar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 170, 0),
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, 0),
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
			}),
		})
	end
end
return {
	ActionPoints = ActionPoints,
}
