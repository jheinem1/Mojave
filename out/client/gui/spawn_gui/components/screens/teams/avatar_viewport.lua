-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Avatar = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar").Avatar
local AvatarViewportComponent
do
	AvatarViewportComponent = Roact.Component:extend("AvatarViewportComponent")
	function AvatarViewportComponent:init(props)
		self.viewportRef = Roact.createRef()
		self.avatarGenerator = Avatar.new(props.player)
	end
	AvatarViewportComponent.didMount = TS.async(function(self)
		local viewport = self.viewportRef:getValue()
		if viewport then
			local camera = Instance.new("Camera")
			camera.CFrame = CFrame.lookAt(Vector3.new(0, 0, -5), Vector3.new(0, 0, 0))
			camera.CameraType = Enum.CameraType.Scriptable
			camera.FieldOfView = 70
			local character = self.avatarGenerator:loadCharacterR6()
			local _value = self.props.shirtId
			if _value ~= 0 and _value == _value and _value then
				self.avatarGenerator:changeShirt(character, self.props.shirtId)
			end
			local _value_1 = self.props.pantsId
			if _value_1 ~= 0 and _value_1 == _value_1 and _value_1 then
				self.avatarGenerator:changePants(character, self.props.pantsId)
			end
			camera.Parent = viewport
			viewport.CurrentCamera = camera
			character.Parent = viewport
		end
	end)
	function AvatarViewportComponent:render()
		return Roact.createFragment({
			Avatar = Roact.createElement("ViewportFrame", {
				Ambient = Color3.fromRGB(106, 106, 106),
				BackgroundTransparency = 1,
				LightColor = Color3.fromRGB(255, 255, 255),
				LightDirection = Vector3.new(2, -1, -1),
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 2,
				Visible = true,
				[Roact.Ref] = self.viewportRef,
			}),
		})
	end
end
return {
	AvatarViewportComponent = AvatarViewportComponent,
}
