-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local RunService = TS.import(script, TS.getModule(script, "services")).RunService
local FactionManager
do
	FactionManager = setmetatable({}, {
		__tostring = function()
			return "FactionManager"
		end,
	})
	FactionManager.__index = FactionManager
	function FactionManager.new(...)
		local self = setmetatable({}, FactionManager)
		self:constructor(...)
		return self
	end
	function FactionManager:constructor()
	end
end
--[[
	*
	* Used for caching player group information on the server.
	* **ONLY ACCESSIBLE FROM THE SERVER**
]]
local function startCaching()
	if RunService:IsClient() then
		error("Cannot instantiate class on the client")
	end
	local factions = {}
end
local Factions
do
	Factions = setmetatable({}, {
		__tostring = function()
			return "Factions"
		end,
	})
	Factions.__index = Factions
	function Factions.new(...)
		local self = setmetatable({}, Factions)
		self:constructor(...)
		return self
	end
	function Factions:constructor()
	end
end
return {
	startCaching = startCaching,
	FactionManager = FactionManager,
	default = Factions,
}
