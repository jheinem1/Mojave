-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Scope
do
	Scope = Roact.Component:extend("Scope")
	function Scope:init()
	end
	function Scope:render()
		return Roact.createFragment({
			ScopeOverlay = Roact.createElement("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://358324484",
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				Position = UDim2.new(0.5, -200, 0.5, -200),
				Size = UDim2.new(0, 400, 0, 400),
				Visible = false,
				ZIndex = 10,
			}, {
				Frame4 = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, -1500, 1, 0),
					Size = UDim2.new(0, 3000, 0, 600),
					ZIndex = 10,
				}),
				Frame3 = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, -1500, 0, -600),
					Size = UDim2.new(0, 3000, 0, 600),
					ZIndex = 10,
				}),
				Frame1 = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0, 0.5, -1500),
					Size = UDim2.new(0, 600, 0, 3000),
					ZIndex = 10,
				}),
				Frame2 = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, -600, 0.5, -1500),
					Size = UDim2.new(0, 600, 0, 3000),
					ZIndex = 10,
				}),
			}),
		})
	end
end
return {
	Scope = Scope,
}
