-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local Settings
do
	Settings = Roact.Component:extend("Settings")
	function Settings:init()
		local _0 = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if _0 ~= nil then
			_0 = _0:FindFirstChild("Settings")
		end
		self.settings = _0
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
					Position = UDim2.new(0, 0, 1, -100),
					Size = UDim2.new(0, 30, 0, 30),
					Selectable = false,
					ZIndex = 2,
					[Roact.Event.MouseButton1Click] = function()
						local _0 = self.settings
						if _0 ~= nil then
							_0 = _0:IsA("ScreenGui")
						end
						if _0 then
							self.settings.Enabled = not self.settings.Enabled
						else
							error("Settings not found!")
						end
					end,
				}, {
					Shadow = Roact.createElement("ImageButton", {
						Active = false,
						BackgroundTransparency = 1,
						Image = "http://www.roblox.com/asset/?id=4677859281",
						ImageColor3 = Color3.new(0, 0, 0),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
						Selectable = false,
					}),
				}),
			}),
		})
	end
end
return {
	Settings = Settings,
}
