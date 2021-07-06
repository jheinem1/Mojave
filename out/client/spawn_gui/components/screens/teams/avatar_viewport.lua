-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Avatar = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar").Avatar
local AvatarViewportComponent
do
	AvatarViewportComponent = Roact.Component:extend("AvatarViewportComponent")
	function AvatarViewportComponent:init(props)
		self.viewportRef = Roact.createRef()
		self.avatarGenerator = Avatar.new(props.player)
	end
	function AvatarViewportComponent:didMount()
		local viewport = self.viewportRef:getValue()
		if viewport then
			local camera = Instance.new("Camera")
			camera.CFrame = CFrame.fromOrientation(0, 0, 0)
			camera.CameraType = Enum.CameraType.Scriptable
			camera.FieldOfView = 70
			local character = self.avatarGenerator:loadCharacter()
			local _0 = self.props.shirtId
			if _0 ~= 0 and _0 == _0 and _0 then
				self.avatarGenerator:changeShirt(character, self.props.shirtId)
			end
			local _1 = self.props.pantsId
			if _1 ~= 0 and _1 == _1 and _1 then
				self.avatarGenerator:changePants(character, self.props.pantsId)
			end
			character:SetPrimaryPartCFrame(CFrame.new(16.5, -3, 7))
			camera.Parent = viewport
			viewport.CurrentCamera = camera
			character.Parent = viewport
		end
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
				Visible = true,
				[Roact.Ref] = self.viewportRef,
			}),
		})
	end
end
return {
	AvatarViewportComponent = AvatarViewportComponent,
}
