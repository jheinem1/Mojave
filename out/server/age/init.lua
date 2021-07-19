-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, TS.getModule(script, "@rbxts", "services")).Players
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local AgeHandler
do
	local super = Handler
	AgeHandler = setmetatable({}, {
		__tostring = function()
			return "AgeHandler"
		end,
		__index = super,
	})
	AgeHandler.__index = AgeHandler
	function AgeHandler.new(...)
		local self = setmetatable({}, AgeHandler)
		return self:constructor(...) or self
	end
	function AgeHandler:constructor(...)
		super.constructor(self, ...)
	end
	function AgeHandler:run()
		Players.PlayerAdded:Connect(function(player)
			if player.AccountAge < 7 then
				player:Kick("Your account must be at least a week old in order to play!")
			end
		end)
	end
end
return {
	AgeHandler = AgeHandler,
}
