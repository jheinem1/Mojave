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
		local _1 = _0
		if _1 == nil then
			local _2 = Players.LocalPlayer:WaitForChild("Data", 5)
			if _2 ~= nil then
				_2 = _2:WaitForChild("Caps", 5)
			end
			_1 = _2
		end
		self.capsValue = _1
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
