-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local Players = _services.Players
local RunService = _services.RunService
local UserInputService = _services.UserInputService
local getFactions = TS.import(script, script.Parent.Parent.Parent.Parent.Parent.Parent, "factions").getFactions
local generateShortName = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "factions", "utility_functions").generateShortName
local SpawnCooldownManager = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "spawn", "spawn_cooldown").default
local MapPointComponent
do
	MapPointComponent = Roact.Component:extend("MapPointComponent")
	function MapPointComponent:init(props)
		self.buttonRef = Roact.createRef()
		self.factions = getFactions()
		local relPosition = Vector2.new(props.point.position.X / props.size.X, props.point.position.Y / props.size.Y)
		self.position = UDim2.fromScale(relPosition.X, relPosition.Y)
		self.controllingFaction, self.setControllingFaction = Roact.createBinding(Color3.fromRGB(79, 79, 79))
		local _factions = self.factions
		local _arg0 = function(factions)
			local _arg0_1 = function(faction)
				return props.point.controllingFaction == faction.groupId
			end
			-- ▼ ReadonlyArray.find ▼
			local _result = nil
			for _i, _v in ipairs(factions) do
				if _arg0_1(_v, _i - 1, factions) == true then
					_result = _v
					break
				end
			end
			-- ▲ ReadonlyArray.find ▲
			local existingFaction = _result
			if existingFaction then
				self.setControllingFaction(existingFaction.color.Color)
			end
			props.point.capturePointStatus.Changed:Connect(function(id)
				local _fn = self
				local _arg0_2 = function(faction)
					return id == faction.groupId
				end
				-- ▼ ReadonlyArray.find ▼
				local _result_1 = nil
				for _i, _v in ipairs(factions) do
					if _arg0_2(_v, _i - 1, factions) == true then
						_result_1 = _v
						break
					end
				end
				-- ▲ ReadonlyArray.find ▲
				local _result_2 = _result_1
				if _result_2 ~= nil then
					_result_2 = _result_2.color.Color
				end
				local _condition = _result_2
				if _condition == nil then
					_condition = Color3.fromRGB(79, 79, 79)
				end
				return _fn.setControllingFaction(_condition)
			end)
		end
		_factions:andThen(_arg0)
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
			local controllingFaction = "Loading..."
			local tooltipText = ""
			local _factions = self.factions
			local _arg0 = function(factions)
				local _arg0_1 = function(faction)
					return self.props.point.controllingFaction == faction.groupId
				end
				-- ▼ ReadonlyArray.find ▼
				local _result = nil
				for _i, _v in ipairs(factions) do
					if _arg0_1(_v, _i - 1, factions) == true then
						_result = _v
						break
					end
				end
				-- ▲ ReadonlyArray.find ▲
				local _result_1 = _result
				if _result_1 ~= nil then
					_result_1 = _result_1.shortName
				end
				local _condition = _result_1
				if _condition == nil then
					_condition = "UNKNOWN"
				end
				controllingFaction = _condition
			end
			_factions:andThen(_arg0)
			local mousePos = UserInputService:GetMouseLocation()
			RunService:BindToRenderStep("MapToolTip", 1, function()
				local newMousePos = UserInputService:GetMouseLocation()
				local newTooltipText = "NAME: " .. point.name .. "\nSAFEZONE: " .. (point.safezone and "YES" or "NO") .. "\nCAN SPAWN: " .. (point.canSpawn and SpawnCooldownManager:canSpawn(Players.LocalPlayer, point.name) and "YES" or "NO") .. "\nCONTROLLING FACTION: " .. controllingFaction .. "\nCOOLDOWN: " .. tostring(point.canSpawn and not point.safezone and math.clamp(SpawnCooldownManager:getCooldownSecsRemaining(Players.LocalPlayer, point.name), 0, math.huge) or "NONE")
				if newTooltipText ~= tooltipText and not tooltipBindings.tooltipSelected:getValue() then
					tooltipBindings.setTooltipText(newTooltipText)
					tooltipText = newTooltipText
				end
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
			wait()
			tooltipBindings.setTooltip(true)
		end
	end
	function MapPointComponent:onClick()
		local tooltipBindings = self.props.tooltipBindings
		if not tooltipBindings.tooltipSelected:getValue() and self.props.point.canSpawn and tooltipBindings and SpawnCooldownManager:canSpawn(Players.LocalPlayer, self.props.point.name) then
			self.props.selectedPoint[2](self.props.point)
			tooltipBindings.setTooltipSelected(true)
			local mousePos = UserInputService:GetMouseLocation()
			if not tooltipBindings.tooltip:getValue() then
				tooltipBindings.setTooltip(true)
				tooltipBindings.setTooltipText("")
			end
			tooltipBindings.setTooltipPosition(mousePos)
		elseif tooltipBindings.tooltipSelected:getValue() then
			tooltipBindings.setTooltipSelected(false)
		end
	end
	function MapPointComponent:render()
		local borderColor = self.props.point.safezone and Color3.fromRGB(92, 168, 255) or self.props.point.canSpawn and Color3.fromRGB(255, 226, 86) or Color3.fromRGB(150, 150, 150)
		return Roact.createFragment({
			Destination = Roact.createElement("TextButton", {
				BackgroundColor3 = self.controllingFaction,
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
					Text = generateShortName(self.props.point.name),
				}),
			}),
		})
	end
end
return {
	MapPointComponent = MapPointComponent,
}
