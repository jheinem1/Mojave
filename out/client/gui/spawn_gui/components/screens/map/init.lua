-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "@rbxts", "roact").src)
local Workspace = TS.import(script, TS.getModule(script, "@rbxts", "services")).Workspace
local gameMap = TS.import(script, script.Parent.Parent.Parent.Parent.Parent, "points", "points").default
local Screen = TS.import(script, script.Parent, "screen").Screen
local MapPointComponent = TS.import(script, script, "map_point").MapPointComponent
local TooltipComponent = TS.import(script, script, "tooltip").TooltipComponent
local MapComponent
do
	MapComponent = Roact.Component:extend("MapComponent")
	function MapComponent:init(props)
		self.imageref = Roact.createRef()
		self.posBinding = { Roact.createBinding(UDim2.new()) }
		local tooltip, setTooltip = Roact.createBinding(false)
		local tooltipText, setTooltipText = Roact.createBinding("")
		local tooltipPosition, setTooltipPosition = Roact.createBinding(Vector2.new())
		local tooltipSelected, setTooltipSelected = Roact.createBinding(false)
		self.tooltipBindings = {
			tooltip = tooltip,
			setTooltip = setTooltip,
			tooltipText = tooltipText,
			setTooltipText = setTooltipText,
			tooltipPosition = tooltipPosition,
			setTooltipPosition = setTooltipPosition,
			tooltipSelected = tooltipSelected,
			setTooltipSelected = setTooltipSelected,
		}
		self.selectedPoint = { Roact.createBinding(nil) }
		local _points = gameMap.points
		local _arg0 = function(point)
			return Roact.createElement(MapPointComponent, {
				point = point,
				size = gameMap.size,
				tooltipBindings = self.tooltipBindings,
				selectedPoint = self.selectedPoint,
			})
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_points)
		for _k, _v in ipairs(_points) do
			_newValue[_k] = _arg0(_v, _k - 1, _points)
		end
		-- ▲ ReadonlyArray.map ▲
		self.mapPoints = _newValue
	end
	function MapComponent:onClick()
		self.tooltipBindings.setTooltip(false)
		self.tooltipBindings.setTooltipSelected(false)
	end
	function MapComponent:didMount()
		local ref = self.imageref:getValue()
		local camera = Workspace.CurrentCamera
		if ref and camera then
			self.posBinding[2](UDim2.fromOffset((camera.ViewportSize.X - ref.AbsoluteSize.X) / 2, 0))
			local connection
			connection = camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
				if ref then
					self.posBinding[2](UDim2.fromOffset((camera.ViewportSize.X - ref.AbsoluteSize.X) / 2, 0))
				else
					connection:Disconnect()
				end
			end)
		end
	end
	function MapComponent:render()
		local _ptr = {
			BackgroundColor3 = Color3.fromRGB(46, 46, 46),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0, 36),
			Size = UDim2.new(1, 0, 1, -36),
			[Roact.Event.InputEnded] = function(_frame, input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					self:onClick()
				end
			end,
		}
		local _ptr_1 = {}
		local _length = #_ptr_1
		local _ptr_2 = {
			BackgroundTransparency = 0,
			Position = self.posBinding[1],
			Size = UDim2.new(1, 0, 1, 0),
			BorderSizePixel = 3,
			Image = "rbxassetid://7124206064",
			SizeConstraint = Enum.SizeConstraint.RelativeYY,
			BackgroundColor3 = Color3.fromRGB(143, 130, 31),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderMode = Enum.BorderMode.Inset,
			[Roact.Ref] = self.imageref,
		}
		local _ptr_3 = {}
		local _length_1 = #_ptr_3
		local _ptr_4 = {
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.1, 0.1),
			Size = UDim2.fromScale(0.8, 0.8),
		}
		local _ptr_5 = {}
		local _length_2 = #_ptr_5
		for _k, _v in ipairs(self.mapPoints) do
			_ptr_5[_length_2 + _k] = _v
		end
		_ptr_3[_length_1 + 1] = Roact.createElement("Frame", _ptr_4, _ptr_5)
		_ptr_1.MapFrame = Roact.createElement("ImageLabel", _ptr_2, _ptr_3)
		_ptr_1[_length + 1] = Roact.createElement(TooltipComponent, {
			tooltipBindings = self.tooltipBindings,
			event = {
				onSpawn = function()
					local point = self.selectedPoint[1]:getValue()
					if point then
						self.props.finished(point)
					end
				end,
			},
		})
		return Roact.createFragment({
			Map = Roact.createElement("Frame", _ptr, _ptr_1),
		})
	end
end
local MapScreen
do
	local super = Screen
	MapScreen = setmetatable({}, {
		__tostring = function()
			return "MapScreen"
		end,
		__index = super,
	})
	MapScreen.__index = MapScreen
	function MapScreen.new(...)
		local self = setmetatable({}, MapScreen)
		return self:constructor(...) or self
	end
	function MapScreen:constructor(position, currentScreen, finished)
		super.constructor(self, position, currentScreen)
		self.position = position
		self.currentScreen = currentScreen
		self.finished = finished
		self.name = "Spawn"
	end
	function MapScreen:getScreenComponent()
		return Roact.createElement(MapComponent, {
			finished = self.finished,
		})
	end
end
return {
	MapScreen = MapScreen,
}
