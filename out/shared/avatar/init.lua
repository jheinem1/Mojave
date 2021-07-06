-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local InsertService = _0.InsertService
local Players = _0.Players
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local getR15 = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "avatar", "character_types").getR15
local Avatar
do
	Avatar = setmetatable({}, {
		__tostring = function()
			return "Avatar"
		end,
	})
	Avatar.__index = Avatar
	function Avatar.new(...)
		local self = setmetatable({}, Avatar)
		self:constructor(...)
		return self
	end
	function Avatar:constructor(user)
		self.user = user
		self.appearanceInfo = Players:GetCharacterAppearanceInfoAsync(t.number(user) and user or user.UserId)
	end
	function Avatar:loadCharacter()
		local character = getR15()
		local _1 = self.appearanceInfo.assets
		local _2 = function(asset)
			return InsertService:LoadAsset(asset.id)
		end
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		local _4 = function(model)
			local asset = model:FindFirstChildWhichIsA("Instance")
			if asset then
				if t.instanceIsA("Accessory")(asset) then
					character.Humanoid:AddAccessory(asset)
				elseif t.instanceIsA("ValueBase")(asset) then
					asset.Parent = character.Humanoid
				elseif asset.Name == "R15ArtistIntent" then
					local _5 = asset:GetChildren()
					local _6 = function(bodyPart)
						local _7 = Enum.BodyPartR15:GetEnumItems()
						local _8 = function(item)
							return item.Name == bodyPart.Name
						end
						-- ▼ ReadonlyArray.find ▼
						local _9 = nil
						for _10, _11 in ipairs(_7) do
							if _8(_11, _10 - 1, _7) == true then
								_9 = _11
								break
							end
						end
						-- ▲ ReadonlyArray.find ▲
						local bodyPartType = _9
						if t.instanceIsA("BasePart")(bodyPart) and bodyPartType then
							character.Humanoid:ReplaceBodyPartR15(bodyPartType, bodyPart)
						end
					end
					-- ▼ ReadonlyArray.forEach ▼
					for _7, _8 in ipairs(_5) do
						_6(_8, _7 - 1, _5)
					end
					-- ▲ ReadonlyArray.forEach ▲
					asset:Destroy()
				elseif t.union(t.instanceIsA("Clothing"), t.instanceIsA("ShirtGraphic"))(asset) then
					asset.Parent = character
				elseif t.instanceIsA("SpecialMesh")(asset) and asset.Name == "Mesh" then
					character.Head.Mesh:Destroy()
					asset.Parent = character.Head
				elseif t.instanceIsA("Decal")(asset) and asset.Name == "face" then
					character.Head.face:Destroy()
					asset.Parent = character.Head
				end
			end
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _5, _6 in ipairs(_3) do
			_4(_6, _5 - 1, _3)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local bodyColors = Instance.new("BodyColors")
		bodyColors.HeadColor = BrickColor.new(self.appearanceInfo.bodyColors.headColorId)
		bodyColors.TorsoColor = BrickColor.new(self.appearanceInfo.bodyColors.torsoColorId)
		bodyColors.RightArmColor = BrickColor.new(self.appearanceInfo.bodyColors.rightArmColorId)
		bodyColors.LeftLegColor = BrickColor.new(self.appearanceInfo.bodyColors.leftLegColorId)
		bodyColors.RightLegColor = BrickColor.new(self.appearanceInfo.bodyColors.rightLegColorId)
		bodyColors.LeftArmColor = BrickColor.new(self.appearanceInfo.bodyColors.leftArmColorId)
		character.Name = t.number(self.user) and Players:GetNameFromUserIdAsync(self.user) or self.user.Name
		return character
	end
	function Avatar:changeShirt(character, newShirtId)
		local newShirt = InsertService:LoadAsset(newShirtId):FindFirstChildWhichIsA("Shirt")
		local _1 = InsertService:LoadAsset(newShirtId):GetChildren()
		local _2 = tostring
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		local _4 = newShirt
		local _5 = "Expected shirt, got [" .. table.concat(_3, ", ") .. "] from '" .. tostring(newShirtId) .. "'"
		assert(_4, _5)
		local _6 = character.Shirt
		if _6 ~= nil then
			_6:Destroy()
		end
		newShirt.Parent = character
		return character
	end
	function Avatar:changePants(character, newPantsId)
		local newPants = InsertService:LoadAsset(newPantsId):FindFirstChildWhichIsA("Pants")
		local _1 = InsertService:LoadAsset(newPantsId):GetChildren()
		local _2 = tostring
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		local _4 = newPants
		local _5 = "Expected pants, got [" .. table.concat(_3, ", ") .. "] from '" .. tostring(newPantsId) .. "'"
		assert(_4, _5)
		local _6 = character.Pants
		if _6 ~= nil then
			_6:Destroy()
		end
		newPants.Parent = character
		return character
	end
	function Avatar:loadCharacterR6()
		error("Method not implemented")
		-- const character = getR6();
		-- return character;
	end
end
return {
	Avatar = Avatar,
}
