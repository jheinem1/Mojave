-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Settings
do
	Settings = Roact.Component:extend("Settings")
	function Settings:init()
	end
	function Settings:render()
		return Roact.createFragment({
			Settings = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
			}, {
				Left = Roact.createElement("ImageButton", {
					Active = false,
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4677859281",
					ImageColor3 = Color3.fromRGB(255, 170, 0),
					Position = UDim2.new(0.001, 0, 0.805, 0),
					Selectable = false,
					Size = UDim2.new(0.03, 0, 0.054, 0),
					ZIndex = 50,
				}),
			}),
		})
	end
end
return {
	Settings = Settings,
}
