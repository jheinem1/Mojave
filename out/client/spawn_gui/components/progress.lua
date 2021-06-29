-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ProgressComponent
do
	ProgressComponent = Roact.Component:extend("ProgressComponent")
	function ProgressComponent:init()
	end
	function ProgressComponent:render()
		local _0 = self.props.items
		local _1 = function(item)
			return item
		end
		-- ▼ ReadonlyArray.map ▼
		local _2 = table.create(#_0)
		for _3, _4 in ipairs(_0) do
			_2[_3] = _1(_4, _3 - 1, _0)
		end
		-- ▲ ReadonlyArray.map ▲
		local items = _2
		local _3 = items
		local _4 = Roact.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0.1, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		-- ▼ Array.push ▼
		_3[#_3 + 1] = _4
		-- ▲ Array.push ▲
		return Roact.createElement("Frame", {
			Name = "List",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.3, 70, 0, 0),
			Size = UDim2.new(0.7, -70, 0, 36),
		}, items)
	end
end
return {
	ProgressComponent = ProgressComponent,
}
