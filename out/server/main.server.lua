-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local run = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").run
local AgeHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "age").AgeHandler
local FactionsHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "factions").FactionsHandler
local FactionGeneratorHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "faction_generator").FactionGeneratorHandler
local LegacyLuaHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "legacy_lua").LegacyLuaHandler
local SafezonesHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "safezones", "safezones").SafezonesHandler
local SpawnHandler = TS.import(script, game:GetService("ServerScriptService"), "Server", "spawn").SpawnHandler
local ageHandler = AgeHandler.new()
local factionGeneratorHandler = FactionGeneratorHandler.new()
local factionHandler = FactionsHandler.new()
local safezonesHandler = SafezonesHandler.new()
local spawnHandler = SpawnHandler.new()
local legacyLuaHandler = LegacyLuaHandler.new()
run(ageHandler)
run(factionGeneratorHandler)
run(factionHandler)
run(safezonesHandler)
run(spawnHandler)
run(legacyLuaHandler)
