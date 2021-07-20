-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
local Caps
do
	Caps = Roact.Component:extend("Caps")
	function Caps:init(props)
		local _result = Players.LocalPlayer:FindFirstChild("Data")
		if _result ~= nil then
			_result = _result:FindFirstChild("Caps")
		end
		local _condition = _result
		if _condition == nil then
			local _result_1 = Players.LocalPlayer:WaitForChild("Data", 5)
			if _result_1 ~= nil then
				_result_1 = _result_1:WaitForChild("Caps", 5)
			end
			_condition = _result_1
		end
		self.capsValue = _condition
		self.state = {
			caps = "N/A",
		}
		local capsValue = self.capsValue
		if t.instanceIsA("IntValue")(capsValue) then
			capsValue.Changed:Connect(function(caps)
				return self:setState({
					caps = tostring(caps),
				})
			end)
			self:setState({
				caps = tostring(capsValue.Value),
			})
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
					Position = UDim2.new(0, 13, 1, -130),
					Size = UDim2.new(0, 25, 0, 25),
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://1117379455",
						ImageColor3 = Color3.fromRGB(0, 0, 0),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}),
					Caps = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(1, 5, 0, 0),
						Size = UDim2.new(1, 0, 1, 0),
						Text = self.state.caps,
						TextColor3 = Color3.fromRGB(255, 170, 0),
						TextSize = 20,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 2,
					}, {
						Caps = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = self.state.caps,
							TextColor3 = Color3.new(0, 0, 0),
							TextSize = 20,
							TextXAlignment = Enum.TextXAlignment.Left,
						}),
					}),
				}),
			}),
		})
	end
end
return {
	Caps = Caps,
}
