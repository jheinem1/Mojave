-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Remotes = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "remotes").default
local State
do
	State = Roact.Component:extend("State")
	function State:init(props)
		self.state = {
			safe = false,
		}
		Remotes.Client:Get("InSafezone"):Connect(function(safe)
			return self:setState({
				safe = safe,
			})
		end)
	end
	function State:render()
		return Roact.createFragment({
			Safezone = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.new(0, 4, 0, 4),
				Size = UDim2.new(0, 230, 0, 35),
				Visible = self.state.safe,
			}, {
				Bottom_Bars = Roact.createElement("Frame", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 1, -12),
					Size = UDim2.new(1, 0, 0, 12),
				}),
				Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(0, 5, 0, 5),
					Size = UDim2.new(0, 220, 0, 25),
					Text = "YOU ARE IN A SAFE ZONE.",
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextScaled = true,
					TextSize = 18,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
						Text = "YOU ARE IN A SAFE ZONE.",
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextScaled = true,
						TextSize = 18,
						TextWrapped = true,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Top,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = "YOU ARE IN A SAFE ZONE.",
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextScaled = true,
							TextSize = 18,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextYAlignment = Enum.TextYAlignment.Top,
						}),
					}),
				}),
				Top_Left = Roact.createElement("Frame", {
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
				Top = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 170, 0),
					BorderSizePixel = 0,
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
			}),
		})
	end
end
return {
	State = State,
}
