-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local Caps
do
	Caps = Roact.Component:extend("Caps")
	function Caps:init(props)
		local _0 = Players.LocalPlayer:FindFirstChild("Data")
		if _0 ~= nil then
			_0 = _0:FindFirstChild("Caps")
		end
		self.capsValue = _0
		self.state = {
			caps = (t.instanceIsA("NumberValue")(self.capsValue) and tostring(self.capsValue.Value) or "N/A"),
		}
		if t.instanceIsA("NumberValue")(self.capsValue) then
			self.capsValue.Changed:Connect(function(caps)
				return self:setState({
					caps = tostring(caps),
				})
			end)
		end
	end
	function Caps:render()
		return Roact.createFragment({
			Caps = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
			}, {
				CapsIcon = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 0),
					BackgroundTransparency = 1,
					Image = "rbxassetid://73202079",
					ImageColor3 = Color3.fromRGB(255, 170, 0),
					Position = UDim2.new(0.017, 0, 0.872, 0),
					Size = UDim2.new(0.027, 0, 0.048, 0),
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://1117379455",
						ImageColor3 = Color3.fromRGB(0, 0, 0),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}),
				}),
				Caps = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(0.038, 0, 0.891, 0),
					Size = UDim2.new(0.052, 0, 0.02, 0),
					Text = self.state.caps,
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 20,
					TextStrokeTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 2,
				}),
			}),
		})
	end
end
return {
	Caps = Caps,
}
