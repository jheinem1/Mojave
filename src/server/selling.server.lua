-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local gui = game.ReplicatedStorage.ESell:Clone()
        gui.Parent = p.Character:WaitForChild("HumanoidRootPart")
    end)
end)