-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Players = TS.import(script, TS.getModule(script, "services")).Players
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local ToolComponent
do
	ToolComponent = Roact.Component:extend("ToolComponent")
	function ToolComponent:init(props)
		self.state = {
			toolEquipped = false,
			toolName = "",
			hasGun = false,
			ammo = "",
			maxAmmo = "",
		}
		Players.LocalPlayer.CharacterAdded:Connect(function(character)
			return self:onCharacter(character)
		end)
		if Players.LocalPlayer.Character then
			self:onCharacter(Players.LocalPlayer.Character)
		end
	end
	function ToolComponent:onCharacter(character)
		character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") then
				self:onToolChange(character, child)
			end
		end)
		local existingTool = character:FindFirstChildOfClass("Tool")
		if existingTool then
			self:onToolChange(character, existingTool)
		end
	end
	function ToolComponent:onToolChange(character, tool)
		if tool:FindFirstChild("BlasterSettings") then
			local ammo = tool:FindFirstChild("ammo")
			local _0 = tool:FindFirstChild("BlasterSettings")
			if _0 ~= nil then
				_0 = _0:FindFirstChild("Stats")
				if _0 ~= nil then
					_0 = _0:FindFirstChild("MaxAmmo")
				end
			end
			local maxAmmo = _0
			self:setState({
				toolEquipped = true,
				toolName = tool.Name,
				hasGun = true,
				ammo = t.instanceOf("IntValue")(ammo) and tostring(ammo.Value) or "N/A",
				maxAmmo = t.instanceOf("IntValue")(maxAmmo) and tostring(maxAmmo.Value) or "N/A",
			})
		else
			self:setState({
				toolEquipped = true,
				toolName = tool.Name,
				hasGun = false,
			})
		end
		tool.AncestryChanged:Connect(function()
			if tool.Parent ~= character then
				self:setState({
					toolEquipped = false,
				})
				local newTool = character:FindFirstChildOfClass("Tool")
				if newTool then
					self:onToolChange(character, newTool)
				end
			end
		end)
	end
	function ToolComponent:render()
		return Roact.createFragment({
			Ammo = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -106, 1, -136),
				Size = UDim2.new(0, 100, 0, 80),
				Visible = self.state.toolEquipped,
			}, {
				MagAmmo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 40),
					Text = self.state.ammo,
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
					Visible = self.state.hasGun,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 0, 40),
						Text = self.state.ammo,
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 0, 40),
							Text = self.state.ammo,
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				TotalAmmo = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 40),
					Size = UDim2.new(1, 0, 0, 40),
					Text = self.state.maxAmmo,
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 24,
					ZIndex = 2,
					Visible = self.state.hasGun,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 0, 40),
						Text = self.state.maxAmmo,
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 24,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 0, 40),
							Text = self.state.maxAmmo,
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 24,
						}),
					}),
				}),
				Bar = Roact.createElement("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 170, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0.5, -34, 0.5, -1),
					Size = UDim2.new(0, 70, 0, 2),
					ZIndex = 3,
					Visible = self.state.hasGun,
				}, {
					Bar = Roact.createElement("Frame", {
						BackgroundColor3 = Color3.fromRGB(67, 67, 67),
						BorderSizePixel = 0,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}, {
						Bar = Roact.createElement("Frame", {
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BorderSizePixel = 0,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
						}),
					}),
				}),
				ToolName = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.ArialBold,
					Position = UDim2.new(0, -10, 1, 0),
					Size = UDim2.new(0, 100, 0, 10),
					Text = self.state.toolName,
					TextColor3 = Color3.fromRGB(255, 170, 0),
					TextSize = 18,
					TextXAlignment = Enum.TextXAlignment.Right,
					ZIndex = 2,
				}, {
					Shadow = Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.ArialBold,
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
						Text = self.state.toolName,
						TextColor3 = Color3.fromRGB(67, 67, 67),
						TextSize = 18,
						TextXAlignment = Enum.TextXAlignment.Right,
					}, {
						Shadow = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.ArialBold,
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
							Text = self.state.toolName,
							TextColor3 = Color3.fromRGB(67, 67, 67),
							TextSize = 18,
							TextXAlignment = Enum.TextXAlignment.Right,
						}),
					}),
				}),
				FiringModeIcon = Roact.createElement("ImageLabel", {
					BackgroundTransparency = 1,
					Image = "rbxassetid://358920621",
					ImageColor3 = Color3.fromRGB(255, 170, 0),
					ImageRectOffset = Vector2.new(0, 156),
					ImageRectSize = Vector2.new(144, 156),
					Position = UDim2.new(0, -10, 0.5, -10),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 2,
					Visible = self.state.hasGun,
				}, {
					Shadow = Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://358920621",
						ImageColor3 = Color3.fromRGB(67, 67, 67),
						ImageRectOffset = Vector2.new(0, 156),
						ImageRectSize = Vector2.new(144, 156),
						Position = UDim2.new(0, 1, 0, 1),
						Size = UDim2.new(1, 0, 1, 0),
					}, {
						Shadow = Roact.createElement("ImageLabel", {
							BackgroundTransparency = 1,
							Image = "rbxassetid://358920621",
							ImageColor3 = Color3.fromRGB(67, 67, 67),
							ImageRectOffset = Vector2.new(0, 156),
							ImageRectSize = Vector2.new(144, 156),
							Position = UDim2.new(0, 1, 0, 1),
							Size = UDim2.new(1, 0, 1, 0),
						}),
					}),
				}),
			}),
		})
	end
end
return {
	ToolComponent = ToolComponent,
}
