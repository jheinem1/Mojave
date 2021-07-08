-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "rotatedregion3"))
local _0 = TS.import(script, TS.getModule(script, "services"))
local RunService = _0.RunService
local Workspace = _0.Workspace
local t = TS.import(script, TS.getModule(script, "t").lib.ts).t
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
		newPart.CFrame = part.CFrame
		newPart.Size = part.Size
		newPart.Shape = t.instanceIsA("Part")(part) and part.Shape or Enum.PartType.Block
		newPart.Anchored = true
		newPart.Transparency = 1
		newPart.CanCollide = false
		newPart.CanTouch = true
		newPart.Parent = RunService:IsClient() and Workspace or nil
		newPart.Name = tostring(self)
		self.part = newPart
		self.rotatedRegion3 = RotatedRegion3.FromPart(self.part)
	end
	BasePartRegion.enteredRegion = TS.async(function(self, part)
		if RunService:IsClient() then
			local inRegion = self:isInRegion(part)
			while not inRegion do
				inRegion = (part.Touched:Wait()) == self.part
			end
		else
			while self:isInRegion(part) do
				RunService.Heartbeat:Wait()
			end
		end
	end)
	BasePartRegion.leftRegion = TS.async(function(self, part)
		if RunService:IsClient() then
			local inRegion = self:isInRegion(part)
			while inRegion do
				inRegion = not ((part.TouchEnded:Wait()) == self.part)
			end
		else
			print(self:isInRegion(part))
			while self:isInRegion(part) do
				RunService.Heartbeat:Wait()
			end
		end
	end)
	function BasePartRegion:isInRegion(part)
		return self.rotatedRegion3:CastPoint(part.Position)
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
		local _1 = part.Position
		local _2 = self.center
		return (_1 - _2).Magnitude <= self.radius
	end
	function SphereRegion:getDistance(part)
		local _1 = part.Position
		local _2 = self.center
		return (_1 - _2).Magnitude
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
		local _1 = TS.Promise
		local _2 = self.regions
		local _3 = function(region)
			return region:enteredRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _4 = table.create(#_2)
		for _5, _6 in ipairs(_2) do
			_4[_5] = _3(_6, _5 - 1, _2)
		end
		-- ▲ ReadonlyArray.map ▲
		return _1.race(_4)
	end)
	RegionUnion.leftRegion = TS.async(function(self, part)
		local _1 = TS.Promise
		local _2 = self.regions
		local _3 = function(region)
			return region:leftRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _4 = table.create(#_2)
		for _5, _6 in ipairs(_2) do
			_4[_5] = _3(_6, _5 - 1, _2)
		end
		-- ▲ ReadonlyArray.map ▲
		return _1.all(_4)
	end)
	function RegionUnion:isInRegions(part)
		local _1 = self.regions
		local _2 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.filter ▼
		local _3 = {}
		local _4 = 0
		for _5, _6 in ipairs(_1) do
			if _2(_6, _5 - 1, _1) == true then
				_4 += 1
				_3[_4] = _6
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		return _3
	end
	function RegionUnion:isInRegion(part)
		local _1 = self.regions
		local _2 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.find ▼
		local _3 = nil
		for _4, _5 in ipairs(_1) do
			if _2(_5, _4 - 1, _1) == true then
				_3 = _5
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		return _3
	end
end
return {
	BasePartRegion = BasePartRegion,
	SphereRegion = SphereRegion,
	RegionUnion = RegionUnion,
}
