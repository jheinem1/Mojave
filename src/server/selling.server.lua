-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if ReplicatedStorage.ESell then
            local gui = game.ReplicatedStorage.ESell:Clone()
            gui.Parent = player.Character:WaitForChild("HumanoidRootPart")
        else
            warn("ESell not found in ReplicatedStorage- selling may not function properly.")
        end
    end)
end)