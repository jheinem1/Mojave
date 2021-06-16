-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local Players = game:GetService("Players")

--- outdated context, needs to be redone
function NameTag(p: Player)
    -- print("tagging")
    local GroupId = 4978642
    local gui = game.ReplicatedStorage.ESell:Clone()
    gui.Parent = p.Character:WaitForChild("HumanoidRootPart")
    local Head = game.ReplicatedStorage.Rank:Clone()
    Head.Parent = p.Character.Head
    p.Character:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    if p:GetRankInGroup(GroupId) >= 252 then
        Head.Background.RGB.Disabled = false
    else
        Head.Background.RGB:Destroy()
    end
    for i, v in pairs(Head.Background:GetChildren()) do
        if not v:IsA("Script") then
            v.TextColor3 = p.Team.TeamColor.Color
            if v.Name == "DivisionRank" then
                v.Text = p.Team.Name
            elseif v.Name == "Rank" then
                v.Text = p:GetRoleInGroup(GroupId)
            elseif v.Name == "UserN" then
                v.Text = p.Name
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        NameTag(player)
    end)
end)