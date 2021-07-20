-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local TextService = _services.TextService
local Workspace = _services.Workspace
local TooltipComponent
do
	TooltipComponent = Roact.Component:extend("TooltipComponent")
	function TooltipComponent:init(props)
		self.size = Vector2.new(250, 10)
		self.ref = Roact.createRef()
		self.tooltipBindings = props.tooltipBindings
	end
	function TooltipComponent:render()
		local tooltipBindings = self.tooltipBindings
		return Roact.createFragment({
			Tooltip = Roact.createElement("Frame", {
				BackgroundColor3 = Color3.fromRGB(126, 111, 42),
				BorderColor3 = Color3.fromRGB(255, 226, 86),
				BorderSizePixel = 2,
				Position = tooltipBindings.tooltipPosition:map(function(cursor)
					local _viewportSize = Workspace.CurrentCamera
					if _viewportSize ~= nil then
						_viewportSize = _viewportSize.ViewportSize
					end
					local viewportSize = _viewportSize
					if viewportSize then
						local _vector2 = Vector2.new(0, -36)
						cursor = cursor + _vector2
						local size = self.size
						local spawnButtonSizeY = self.tooltipBindings.tooltipSelected:getValue() and 20 or 0
						local position = Vector2.new(cursor.X + 5, cursor.Y - size.Y - spawnButtonSizeY - 5)
						if position.X + size.X + 2 > viewportSize.X then
							position = Vector2.new(viewportSize.X - size.X, position.Y)
						end
						if position.Y < 0 then
							position = Vector2.new(position.X, 0)
						end
						if position.Y + size.Y + spawnButtonSizeY >= cursor.Y then
							position = Vector2.new(position.X, cursor.Y + 5)
							if position.Y + size.Y + spawnButtonSizeY > viewportSize.Y then
								position = Vector2.new(position.X, viewportSize.Y - size.Y - spawnButtonSizeY)
							end
						end
						return UDim2.fromOffset(position.X, position.Y)
					else
						return UDim2.new()
					end
				end),
				Size = self.tooltipBindings.tooltipText:map(function(text)
					local textSize = TextService:GetTextSize(text, 18, Enum.Font.SourceSans, Vector2.new(self.size.X, math.huge))
					textSize = Vector2.new(self.size.X, textSize.Y + 10)
					self.size = textSize
					return UDim2.fromOffset(textSize.X, textSize.Y)
				end),
				Visible = tooltipBindings.tooltip,
				ZIndex = 2,
				[Roact.Ref] = self.ref,
			}, {
				DestinationInfo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.SourceSans,
					Position = UDim2.new(0, 5, 0, 0),
					Size = UDim2.new(1, -10, 1, 0),
					Text = tooltipBindings.tooltipText,
					TextColor3 = Color3.fromRGB(255, 226, 86),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextWrapped = true,
				}),
				Tooltip = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(126, 111, 42),
					BorderColor3 = Color3.fromRGB(255, 226, 86),
					BorderSizePixel = 2,
					Position = UDim2.new(0, 0, 1, 0),
					Size = UDim2.new(1, 0, 0, 20),
					Visible = tooltipBindings.tooltipSelected,
				}, {
					SpawnButton = Roact.createElement("TextButton", {
						BackgroundTransparency = 1,
						Font = Enum.Font.SourceSansBold,
						Position = UDim2.new(0, 5, 0, 0),
						Size = UDim2.new(1, -10, 1, 0),
						Text = "SPAWN",
						TextColor3 = Color3.fromRGB(255, 226, 86),
						TextSize = 16,
						AutoButtonColor = false,
						[Roact.Event.MouseButton1Click] = function()
							local _result = self.props.event
							if _result ~= nil then
								_result = _result.onSpawn
							end
							local _result_1
							if _result then
								local _result_2 = self.props.event
								if _result_2 ~= nil then
									_result_2 = _result_2.onSpawn()
								end
								_result_1 = _result_2
							else
								_result_1 = nil
							end
							return _result_1
						end,
					}),
				}),
			}),
		})
	end
end
return {
	TooltipComponent = TooltipComponent,
}
