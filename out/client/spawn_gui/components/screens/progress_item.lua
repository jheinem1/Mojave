-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ProgressItemComponent
do
	ProgressItemComponent = Roact.Component:extend("ProgressItemComponent")
	function ProgressItemComponent:init()
	end
	function ProgressItemComponent:render()
		local _0 = {
			BackgroundTransparency = 1,
			Font = Enum.Font.SourceSansBold,
			LayoutOrder = self.props.order,
			Position = UDim2.new(0, 70, 0, 0),
			Size = UDim2.new(0.2, 0, 0, 36),
			Text = tostring(self.props.name),
			TextColor3 = self.props.selected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(172, 172, 172),
			TextScaled = true,
			TextSize = 24,
			TextWrapped = true,
		}
		for _1, _2 in pairs(self.props.Event) do
			_0[Roact.Event[_1]] = _2
		end
		return Roact.createFragment({
			[tostring(self.props.name)] = Roact.createElement("TextButton", _0),
		})
	end
end
return {
	ProgressItemComponent = ProgressItemComponent,
}
