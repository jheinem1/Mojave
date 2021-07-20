-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Handler = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").Handler
local generateTeams = TS.import(script, game:GetService("ServerScriptService"), "Server", "team_generator", "generator_funcs").generateTeams
local TeamGeneratorHandler
do
	local super = Handler
	TeamGeneratorHandler = setmetatable({}, {
		__tostring = function()
			return "TeamGeneratorHandler"
		end,
		__index = super,
	})
	TeamGeneratorHandler.__index = TeamGeneratorHandler
	function TeamGeneratorHandler.new(...)
		local self = setmetatable({}, TeamGeneratorHandler)
		return self:constructor(...) or self
	end
	function TeamGeneratorHandler:constructor(...)
		super.constructor(self, ...)
		self.name = "TeamGenerator"
	end
	function TeamGeneratorHandler:run()
		generateTeams()
	end
end
return {
	TeamGeneratorHandler = TeamGeneratorHandler,
}
