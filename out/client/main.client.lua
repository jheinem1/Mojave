-- Compiled with roblox-ts v1.2.2
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local run = TS.import(script, game:GetService("ReplicatedStorage"), "Shared", "handler").run
local GuiHandler = TS.import(script, script.Parent, "gui").GuiHandler
local SafezonesHandler = TS.import(script, script.Parent, "safezones", "safezones").SafezonesHandler
local guiHandler = GuiHandler.new()
local safezones = SafezonesHandler.new()
run(guiHandler)
run(safezones)
