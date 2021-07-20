-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local OnJoinHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "legacy_lua", "onjoin").OnJoinHandler
local SellingHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "legacy_lua", "selling").SellingHandler
--[[
	*
	* Runs legacy lua code such as nametags and a fix for the selling script
]]
local LegacyLuaHandler
do
	local super = Handler
	LegacyLuaHandler = setmetatable({}, {
		__tostring = function()
			return "LegacyLuaHandler"
		end,
		__index = super,
	})
	LegacyLuaHandler.__index = LegacyLuaHandler
	function LegacyLuaHandler.new(...)
		local self = setmetatable({}, LegacyLuaHandler)
		return self:constructor(...) or self
	end
	function LegacyLuaHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "Legacy Lua"
	end
	function LegacyLuaHandler:run()
		OnJoinHandler:run()
		SellingHandler:run()
	end
end
return {
	LegacyLuaHandler = LegacyLuaHandler,
}
