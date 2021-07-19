-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Handler
do
	Handler = {}
	function Handler:constructor()
	end
end
local run = TS.async(function(handler)
	TS.try(function()
		handler:run()
	end, function(error)
		warn('Failed to load handler "' .. handler.name .. '" with error "' .. tostring(error) .. '".')
	end)
end)
return {
	run = run,
	Handler = Handler,
}
