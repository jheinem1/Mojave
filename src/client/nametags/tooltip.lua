-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Vendor.Roact)

local PlayerToolTip = Roact.Component:extend("PlayerToolTip")

local message = Instance.new("Message")
