-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ObjectEvent = TS.import(script, TS.getModule(script, "object-event"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local Players = _0.Players
local RunService = _0.RunService
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
local BaseRegion
do
	BaseRegion = {}
	function BaseRegion:constructor(regions)
		self.parts = {}
		self.disabled = false
		self.enteredRegion = ObjectEvent.new()
		self.leftRegion = ObjectEvent.new()
		if t.instanceIsA("BasePart")(regions[1]) then
			local _1 = regions
			local _2 = function(part)
				local _3 = self.parts
				local _4 = part
				-- ▼ Array.push ▼
				_3[#_3 + 1] = _4
				-- ▲ Array.push ▲
				return RotatedRegion3.FromPart(part)
			end
			-- ▼ ReadonlyArray.map ▼
			local _3 = table.create(#_1)
			for _4, _5 in ipairs(_1) do
				_3[_4] = _2(_5, _4 - 1, _1)
			end
			-- ▲ ReadonlyArray.map ▲
			self.regions = _3
		else
			self.regions = regions
		end
	end
	function BaseRegion:kill()
		self.disabled = true
	end
end
local GlobalRegions
do
	local super = BaseRegion
	GlobalRegions = setmetatable({}, {
		__tostring = function()
			return "GlobalRegions"
		end,
		__index = super,
	})
	GlobalRegions.__index = GlobalRegions
	function GlobalRegions.new(...)
		local self = setmetatable({}, GlobalRegions)
		self:constructor(...)
		return self
	end
	function GlobalRegions:constructor(parts)
		super.constructor(self, parts)
		self:regionCheck(self.enteredRegion, self.leftRegion, self.regions)
	end
	GlobalRegions.regionCheck = TS.async(function(self, enteredRegion, leftRegion, regions)
		local connection
		local inRegion = setmetatable({}, {
			__mode = "k",
		})
		local check = function()
			if not self.disabled then
				local _1 = Players:GetPlayers()
				local _2 = function(player)
					local _3 = player.Character
					if _3 ~= nil then
						_3 = _3:FindFirstChild("HumanoidRootPart")
					end
					local rootPart = _3
					local index = -1
					local _4 = t.instanceIsA("BasePart")(rootPart)
					if _4 then
						local _5 = regions
						local _6 = function(region, i)
							index = i
							return region:CastPart(rootPart)
						end
						-- ▼ ReadonlyArray.some ▼
						local _7 = false
						for _8, _9 in ipairs(_5) do
							if _6(_9, _8 - 1, _5) then
								_7 = true
								break
							end
						end
						-- ▲ ReadonlyArray.some ▲
						_4 = _7
					end
					if _4 then
						local _5 = inRegion
						local _6 = player
						if not _5[_6] then
							local _7 = inRegion
							local _8 = player
							-- ▼ Map.set ▼
							_7[_8] = true
							-- ▲ Map.set ▲
							enteredRegion:Fire(player, self.parts[index + 1])
						end
					else
						local _5 = inRegion
						local _6 = player
						if _5[_6] then
							local _7 = inRegion
							local _8 = player
							-- ▼ Map.delete ▼
							_7[_8] = nil
							-- ▲ Map.delete ▲
							leftRegion:Fire(player, self.parts[index + 1])
						end
					end
				end
				-- ▼ ReadonlyArray.forEach ▼
				for _3, _4 in ipairs(_1) do
					_2(_4, _3 - 1, _1)
				end
				-- ▲ ReadonlyArray.forEach ▲
			else
				connection:Disconnect()
			end
		end
		connection = RunService.Heartbeat:Connect(function()
			return check()
		end)
		check()
	end)
	function GlobalRegions:isInRegion(player)
		local _1 = player.Character
		if _1 ~= nil then
			_1 = _1:FindFirstChild("HumanoidRootPart")
		end
		local rootPart = _1
		local _2 = t.instanceIsA("BasePart")(rootPart)
		if _2 then
			local _3 = super.regions
			local _4 = function(region)
				return region:CastPart(rootPart)
			end
			-- ▼ ReadonlyArray.some ▼
			local _5 = false
			for _6, _7 in ipairs(_3) do
				if _4(_7, _6 - 1, _3) then
					_5 = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			_2 = _5
		end
		if _2 then
			return true
		end
		return false
	end
end
local ClientRegions
do
	local super = BaseRegion
	ClientRegions = setmetatable({}, {
		__tostring = function()
			return "ClientRegions"
		end,
		__index = super,
	})
	ClientRegions.__index = ClientRegions
	function ClientRegions.new(...)
		local self = setmetatable({}, ClientRegions)
		self:constructor(...)
		return self
	end
	function ClientRegions:constructor(parts, client)
		if client == nil then
			client = Players.LocalPlayer
		end
		super.constructor(self, parts)
		local _1 = client
		assert(_1, "Client argument must be provided on the server")
		self.client = client
		self:regionCheck(self.enteredRegion, self.leftRegion, self.regions, client)
	end
	ClientRegions.regionCheck = TS.async(function(self, enteredRegion, leftRegion, regions, client)
		local connection
		local inRegion = false
		local weakRef = setmetatable({
			this = self,
		}, {
			__mode = "k",
		})
		local check = function()
			if not self.disabled then
				local _1 = client.Character
				if _1 ~= nil then
					_1 = _1:FindFirstChild("HumanoidRootPart")
				end
				local rootPart = _1
				local index = -1
				local _2 = t.instanceIsA("BasePart")(rootPart)
				if _2 then
					local _3 = regions
					local _4 = function(region, i)
						index = i
						return region:CastPart(rootPart)
					end
					-- ▼ ReadonlyArray.some ▼
					local _5 = false
					for _6, _7 in ipairs(_3) do
						if _4(_7, _6 - 1, _3) then
							_5 = true
							break
						end
					end
					-- ▲ ReadonlyArray.some ▲
					_2 = _5
				end
				if _2 then
					if not inRegion then
						inRegion = true
						enteredRegion:Fire(client, self.parts[index + 1])
					end
				elseif inRegion then
					inRegion = false
					leftRegion:Fire(client, self.parts[index + 1])
				end
			else
				connection:Disconnect()
			end
		end
		connection = RunService.Heartbeat:Connect(function()
			return check()
		end)
		check()
	end)
	function ClientRegions:isInRegion()
		local _1 = self.client.Character
		if _1 ~= nil then
			_1 = _1:FindFirstChild("HumanoidRootPart")
		end
		local rootPart = _1
		local _2 = t.instanceIsA("BasePart")(rootPart)
		if _2 then
			local _3 = self.regions
			local _4 = function(region)
				return region:CastPart(rootPart)
			end
			-- ▼ ReadonlyArray.some ▼
			local _5 = false
			for _6, _7 in ipairs(_3) do
				if _4(_7, _6 - 1, _3) then
					_5 = true
					break
				end
			end
			-- ▲ ReadonlyArray.some ▲
			_2 = _5
		end
		if _2 then
			return true
		end
		return false
	end
end
return {
	GlobalRegions = GlobalRegions,
	ClientRegions = ClientRegions,
}
