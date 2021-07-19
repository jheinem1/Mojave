-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local _faction = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions", "faction")
local quitCaching = _faction.quitCaching
local startCaching = _faction.startCaching
local FactionHandler
do
	local super = Handler
	FactionHandler = setmetatable({}, {
		__tostring = function()
			return "FactionHandler"
		end,
		__index = super,
	})
	FactionHandler.__index = FactionHandler
	function FactionHandler.new(...)
		local self = setmetatable({}, FactionHandler)
		return self:constructor(...) or self
	end
	function FactionHandler:constructor(...)
		super.constructor(self, ...)
	end
	function FactionHandler:run()
		startCaching()
		game:BindToClose(function()
			return quitCaching()
		end)
	end
end
return {
	FactionHandler = FactionHandler,
}
