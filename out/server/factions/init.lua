-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local _faction = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions", "faction")
local quitCaching = _faction.quitCaching
local startCaching = _faction.startCaching
--[[
	*
	* Caches faction information for client remotes and such
]]
local FactionsHandler
do
	local super = Handler
	FactionsHandler = setmetatable({}, {
		__tostring = function()
			return "FactionsHandler"
		end,
		__index = super,
	})
	FactionsHandler.__index = FactionsHandler
	function FactionsHandler.new(...)
		local self = setmetatable({}, FactionsHandler)
		return self:constructor(...) or self
	end
	function FactionsHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "Factions"
	end
	function FactionsHandler:run()
		startCaching()
		game:BindToClose(function()
			return quitCaching()
		end)
	end
end
return {
	FactionsHandler = FactionsHandler,
}
