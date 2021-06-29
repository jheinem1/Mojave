-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local AvatarViewportComponent
do
	AvatarViewportComponent = Roact.Component:extend("AvatarViewportComponent")
	function AvatarViewportComponent:init()
	end
	function AvatarViewportComponent:render()
		return Roact.createFragment({
			Avatar = Roact.createElement("ViewportFrame", {
				Ambient = Color3.fromRGB(106, 106, 106),
				BackgroundTransparency = 1,
				LightColor = Color3.fromRGB(255, 255, 255),
				LightDirection = Vector3.new(2, -1, -1),
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 2,
			}),
		})
	end
end
return {
	AvatarViewportComponent = AvatarViewportComponent,
}
