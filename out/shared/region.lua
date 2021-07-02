-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, TS.getModule(script, "services")).RunService
local Region
do
	Region = {}
	function Region:constructor()
	end
end
--[[
	*
	* Rectangular regions are a great way to define event-based areas using Roblox's own physics engine
]]
local BasePartRegion
do
	local super = Region
	BasePartRegion = setmetatable({}, {
		__tostring = function()
			return "BasePartRegion"
		end,
		__index = super,
	})
	BasePartRegion.__index = BasePartRegion
	function BasePartRegion.new(...)
		local self = setmetatable({}, BasePartRegion)
		self:constructor(...)
		return self
	end
	function BasePartRegion:constructor(part)
		super.constructor(self)
		local newPart = Instance.new("Part")
		newPart.Position = part.Position
		newPart.Size = part.Size
		newPart.Anchored = true
		newPart.Transparency = 1
		newPart.CanCollide = false
		self.part = newPart
	end
	BasePartRegion.enteredRegion = TS.async(function(self, part)
		local inRegion = self:isInRegion(part)
		while not inRegion do
			inRegion = (part.Touched:Wait()) == self.part
		end
	end)
	BasePartRegion.leftRegion = TS.async(function(self, part)
		local inRegion = self:isInRegion(part)
		while inRegion do
			inRegion = not ((part.TouchEnded:Wait()) == self.part)
		end
	end)
	function BasePartRegion:isInRegion(part)
		local _0 = part:GetTouchingParts()
		local _1 = function(part)
			return part == self.part
		end
		-- ▼ ReadonlyArray.some ▼
		local _2 = false
		for _3, _4 in ipairs(_0) do
			if _1(_4, _3 - 1, _0) then
				_2 = true
				break
			end
		end
		-- ▲ ReadonlyArray.some ▲
		return _2
	end
end
--[[
	*
	* Spherical regions offer a much faster alternative to rectangular regions, as simple distance checks are much faster
]]
local SphereRegion
do
	local super = Region
	SphereRegion = setmetatable({}, {
		__tostring = function()
			return "SphereRegion"
		end,
		__index = super,
	})
	SphereRegion.__index = SphereRegion
	function SphereRegion.new(...)
		local self = setmetatable({}, SphereRegion)
		self:constructor(...)
		return self
	end
	function SphereRegion:constructor(sphere)
		super.constructor(self)
		self.center = sphere.Position
		self.radius = math.min(sphere.Size.X, sphere.Size.Y, sphere.Size.Z)
	end
	SphereRegion.enteredRegion = TS.async(function(self, part)
		while not self:isInRegion(part) do
			RunService.Heartbeat:Wait()
		end
	end)
	SphereRegion.leftRegion = TS.async(function(self, part)
		while self:isInRegion(part) do
			RunService.Heartbeat:Wait()
		end
	end)
	function SphereRegion:isInRegion(part)
		local _0 = part.Position
		local _1 = self.center
		return (_0 - _1).Magnitude <= self.radius
	end
	function SphereRegion:getDistance(part)
		local _0 = part.Position
		local _1 = self.center
		return (_0 - _1).Magnitude
	end
end
--[[
	*
	* A handy way to group regions of any type
]]
local RegionUnion
do
	RegionUnion = setmetatable({}, {
		__tostring = function()
			return "RegionUnion"
		end,
	})
	RegionUnion.__index = RegionUnion
	function RegionUnion.new(...)
		local self = setmetatable({}, RegionUnion)
		self:constructor(...)
		return self
	end
	function RegionUnion:constructor(regions)
		self.regions = regions
	end
	RegionUnion.enteredRegion = TS.async(function(self, part)
		local _0 = TS.Promise
		local _1 = self.regions
		local _2 = function(region)
			return region:enteredRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		return _0.race(_3)
	end)
	RegionUnion.leftRegion = TS.async(function(self, part)
		local _0 = TS.Promise
		local _1 = self.regions
		local _2 = function(region)
			return region:leftRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _3 = table.create(#_1)
		for _4, _5 in ipairs(_1) do
			_3[_4] = _2(_5, _4 - 1, _1)
		end
		-- ▲ ReadonlyArray.map ▲
		return _0.race(_3)
	end)
	function RegionUnion:isInRegions(part)
		local _0 = self.regions
		local _1 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.filter ▼
		local _2 = {}
		local _3 = 0
		for _4, _5 in ipairs(_0) do
			if _1(_5, _4 - 1, _0) == true then
				_3 += 1
				_2[_3] = _5
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		return _2
	end
	function RegionUnion:isInRegion(part)
		local _0 = self.regions
		local _1 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.find ▼
		local _2 = nil
		for _3, _4 in ipairs(_0) do
			if _1(_4, _3 - 1, _0) == true then
				_2 = _4
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		return _2
	end
end
return {
	BasePartRegion = BasePartRegion,
	SphereRegion = SphereRegion,
	RegionUnion = RegionUnion,
}
