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
	function BaseRegion:constructor(parts)
		self.parts = {}
		self.regions = {}
		self.disabled = false
		self.enteredRegion = ObjectEvent.new()
		self.leftRegion = ObjectEvent.new()
		local _1 = parts
		local _2 = function(part)
			local _3 = parts
			local _4 = part
			-- ▼ Array.push ▼
			_3[#_3 + 1] = _4
			-- ▲ Array.push ▲
			local _5 = self.regions
			local _6 = RotatedRegion3.FromPart(part)
			-- ▼ Array.push ▼
			_5[#_5 + 1] = _6
			-- ▲ Array.push ▲
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _3, _4 in ipairs(_1) do
			_2(_4, _3 - 1, _1)
		end
		-- ▲ ReadonlyArray.forEach ▲
		self:regionCheck()
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
	function GlobalRegions:constructor(...)
		super.constructor(self, ...)
		self.inRegion = setmetatable({}, {
			__mode = "k",
		})
	end
	GlobalRegions.regionCheck = TS.async(function(self)
		local connection
		local weakRef = setmetatable({
			this = self,
		}, {
			__mode = "k",
		})
		connection = RunService.Heartbeat:Connect(function()
			if weakRef.this then
				local _1 = Players:GetPlayers()
				local _2 = function(player)
					local _3 = player.Character
					if _3 ~= nil then
						_3 = _3:FindFirstChild("HumanoidRootPart")
					end
					local rootPart = _3
					local _4 = t.instanceIsA("BasePart")(rootPart)
					if _4 then
						local _5 = super.regions
						local _6 = function(region)
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
						local _5 = weakRef.this.inRegion
						local _6 = player
						if not _5[_6] then
							local _7 = weakRef.this.inRegion
							local _8 = player
							-- ▼ Map.set ▼
							_7[_8] = true
							-- ▲ Map.set ▲
							weakRef.this.enteredRegion:Fire(player)
						end
					else
						local _5 = weakRef.this.inRegion
						local _6 = player
						if _5[_6] then
							local _7 = weakRef.this.inRegion
							local _8 = player
							-- ▼ Map.delete ▼
							_7[_8] = nil
							-- ▲ Map.delete ▲
							weakRef.this.leftRegion:Fire(player)
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
		end)
	end)
	function GlobalRegions:isInRegion(player)
		local _1 = self.inRegion
		local _2 = player
		local _3 = _1[_2]
		if _3 == nil then
			_3 = false
		end
		return _3
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
		self.inRegion = false
		self.client = client
	end
	ClientRegions.regionCheck = TS.async(function(self)
		local connection
		local weakRef = setmetatable({
			this = self,
		}, {
			__mode = "k",
		})
		connection = RunService.Heartbeat:Connect(function()
			if weakRef.this then
				local _1 = weakRef.this.client.Character
				if _1 ~= nil then
					_1 = _1:FindFirstChild("HumanoidRootPart")
				end
				local rootPart = _1
				local _2 = t.instanceIsA("BasePart")(rootPart)
				if _2 then
					local _3 = weakRef.this.regions
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
					if not weakRef.this.inRegion then
						weakRef.this.inRegion = true
						weakRef.this.enteredRegion:Fire(Players.LocalPlayer)
					end
				elseif self.inRegion then
					weakRef.this.inRegion = false
					weakRef.this.leftRegion:Fire(Players.LocalPlayer)
				end
			else
				connection:Disconnect()
			end
		end)
	end)
	function ClientRegions:isInRegion()
		return self.inRegion
	end
end
return {
	GlobalRegions = GlobalRegions,
	ClientRegions = ClientRegions,
}
