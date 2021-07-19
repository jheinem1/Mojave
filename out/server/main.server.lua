-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local AgeHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "age").AgeHandler
local FactionGeneratorHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "faction_generator").FactionGeneratorHandler
local ageHandler = AgeHandler.new()
local factionGeneratorHandler = FactionGeneratorHandler.new()
