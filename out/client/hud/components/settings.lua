-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local Settings
do
	Settings = Roact.Component:extend("Settings")
	function Settings:init(props)
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
						local _result = Players.LocalPlayer:FindFirstChild("PlayerGui")
						if _result ~= nil then
							_result = _result:FindFirstChild("Settings")
						end
						local _condition = _result
						if _condition == nil then
							local _result_1 = Players.LocalPlayer:WaitForChild("PlayerGui", 5)
							if _result_1 ~= nil then
								_result_1 = _result_1:WaitForChild("Settings", 5)
							end
							_condition = _result_1
						end
						local settings = _condition
						local _result_1 = settings
						if _result_1 ~= nil then
							_result_1 = _result_1:IsA("ScreenGui")
						end
						if _result_1 then
							settings.Enabled = not settings.Enabled
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
