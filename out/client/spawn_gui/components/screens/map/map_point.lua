-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local RunService = _services.RunService
local UserInputService = _services.UserInputService
local MapPointComponent
do
	MapPointComponent = Roact.Component:extend("MapPointComponent")
	function MapPointComponent:init(props)
		self.buttonRef = Roact.createRef()
		local relPosition = Vector2.new(props.point.position.X / props.size.X, props.point.position.Y / props.size.Y)
		self.position = UDim2.fromScale(relPosition.X, relPosition.Y)
	end
	function MapPointComponent:inBounds(position, button)
		local _vector2 = Vector2.new(0, -36)
		position = position + _vector2
		if button then
			local buttonPos = button.AbsolutePosition
			local _absoluteSize = button.AbsoluteSize
			local buttonEndPos = buttonPos + _absoluteSize
			if position.X >= buttonPos.X and position.Y >= buttonPos.Y and position.X <= buttonEndPos.X and position.Y <= buttonEndPos.Y then
				return true
			end
		end
		return false
	end
	function MapPointComponent:onHover()
		local tooltipBindings = self.props.tooltipBindings
		local button = self.buttonRef:getValue()
		if tooltipBindings and button then
			local point = self.props.point
			local mousePos = UserInputService:GetMouseLocation()
			RunService:BindToRenderStep("MapToolTip", 1, function()
				local newMousePos = UserInputService:GetMouseLocation()
				if newMousePos ~= mousePos and not tooltipBindings.tooltipSelected:getValue() then
					mousePos = newMousePos
					tooltipBindings.setTooltipPosition(mousePos)
				end
				if not self:inBounds(newMousePos, button) then
					RunService:UnbindFromRenderStep("MapToolTip")
					if not tooltipBindings.tooltipSelected:getValue() then
						tooltipBindings.setTooltip(false)
					end
				end
			end)
			tooltipBindings.setTooltipText("NAME: " .. point.name .. "\nSAFEZONE: " .. (point.safezone and "YES" or "NO") .. "\nCAN SPAWN: " .. (point.canSpawn and "YES" or "NO") .. "\nCONTROLLING FACTION: " .. (self.props.controlling and self.props.controlling:getValue() and self.props.controlling:getValue().shortName or "UNKNOWN"))
			tooltipBindings.setTooltip(true)
		end
	end
	function MapPointComponent:onClick()
		local tooltipBindings = self.props.tooltipBindings
		if not tooltipBindings.tooltipSelected:getValue() and self.props.point.canSpawn and tooltipBindings then
			self.props.selectedPoint[2](self.props.point)
			tooltipBindings.setTooltipSelected(true)
			if not tooltipBindings.tooltip:getValue() then
				tooltipBindings.setTooltip(true)
				tooltipBindings.setTooltipText("")
			end
			local mousePos = UserInputService:GetMouseLocation()
			tooltipBindings.setTooltipPosition(mousePos)
		elseif tooltipBindings.tooltipSelected:getValue() then
			tooltipBindings.setTooltipSelected(false)
		end
	end
	function MapPointComponent:render()
		local borderColor = self.props.point.safezone and Color3.fromRGB(92, 168, 255) or Color3.fromRGB(255, 226, 86)
		return Roact.createFragment({
			Destination = Roact.createElement("TextButton", {
				BackgroundColor3 = self.props.controlling and self.props.controlling:map(function(faction)
					return faction.color.Color
				end) or Color3.new(0.5, 0.5, 0.5),
				BorderColor3 = borderColor,
				BorderSizePixel = 5,
				BorderMode = Enum.BorderMode.Inset,
				Font = Enum.Font.SourceSans,
				Position = self.position,
				Size = UDim2.new(0, 30, 0, 30),
				Text = "",
				TextColor3 = Color3.fromRGB(0, 0, 0),
				TextSize = 14,
				AutoButtonColor = false,
				[Roact.Event.MouseEnter] = function()
					return self:onHover()
				end,
				[Roact.Event.MouseButton1Click] = function()
					return self:onClick()
				end,
				[Roact.Ref] = self.buttonRef,
			}, {
				Title = Roact.createElement("TextLabel", {
					Position = UDim2.new(0.5, -20, -1, 0),
					Size = UDim2.new(0, 40, 1, 0),
					BackgroundTransparency = 1,
					TextSize = 15,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextStrokeColor3 = borderColor,
					TextStrokeTransparency = 0,
					TextYAlignment = Enum.TextYAlignment.Top,
					TextXAlignment = Enum.TextXAlignment.Center,
					Font = Enum.Font.SourceSansBold,
					Text = self.props.point.name,
				}),
			}),
		})
	end
end
return {
	MapPointComponent = MapPointComponent,
}
