-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RotatedRegion3 = TS.import(script, TS.getModule(script, "@rbxts", "rotatedregion3"))
local _services = TS.import(script, TS.getModule(script, "@rbxts", "services"))
local RunService = _services.RunService
local Workspace = _services.Workspace
local t = TS.import(script, TS.getModule(script, "@rbxts", "t").lib.ts).t
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
		return self:constructor(...) or self
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
		return self:constructor(...) or self
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
		local _position = part.Position
		local _center = self.center
		return (_position - _center).Magnitude <= self.radius
	end
	function SphereRegion:getDistance(part)
		local _position = part.Position
		local _center = self.center
		return (_position - _center).Magnitude
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
		return self:constructor(...) or self
	end
	function RegionUnion:constructor(regions)
		self.regions = regions
	end
	RegionUnion.enteredRegion = TS.async(function(self, part)
		local _fn = TS.Promise
		local _regions = self.regions
		local _arg0 = function(region)
			return region:enteredRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_regions)
		for _k, _v in ipairs(_regions) do
			_newValue[_k] = _arg0(_v, _k - 1, _regions)
		end
		-- ▲ ReadonlyArray.map ▲
		return _fn.race(_newValue)
	end)
	RegionUnion.leftRegion = TS.async(function(self, part)
		local _fn = TS.Promise
		local _regions = self.regions
		local _arg0 = function(region)
			return region:leftRegion(part)
		end
		-- ▼ ReadonlyArray.map ▼
		local _newValue = table.create(#_regions)
		for _k, _v in ipairs(_regions) do
			_newValue[_k] = _arg0(_v, _k - 1, _regions)
		end
		-- ▲ ReadonlyArray.map ▲
		return _fn.all(_newValue)
	end)
	function RegionUnion:isInRegions(part)
		local _regions = self.regions
		local _arg0 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.filter ▼
		local _newValue = {}
		local _length = 0
		for _k, _v in ipairs(_regions) do
			if _arg0(_v, _k - 1, _regions) == true then
				_length += 1
				_newValue[_length] = _v
			end
		end
		-- ▲ ReadonlyArray.filter ▲
		return _newValue
	end
	function RegionUnion:isInRegion(part)
		local _regions = self.regions
		local _arg0 = function(region)
			return region:isInRegion(part)
		end
		-- ▼ ReadonlyArray.find ▼
		local _result = nil
		for _i, _v in ipairs(_regions) do
			if _arg0(_v, _i - 1, _regions) == true then
				_result = _v
				break
			end
		end
		-- ▲ ReadonlyArray.find ▲
		return _result
	end
end
return {
	BasePartRegion = BasePartRegion,
	SphereRegion = SphereRegion,
	RegionUnion = RegionUnion,
}
