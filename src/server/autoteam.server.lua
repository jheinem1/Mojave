-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local Teams = game:GetService("Teams")
local teams = {}
local wastelanders = Instance.new("Team")

wastelanders.Name = "Wastelanders"
wastelanders.TeamColor = BrickColor.Gray()
wastelanders.Parent = Teams

local allies = GroupService:GetAlliesAsync(4978642)
while true do
    for _, group in pairs(allies:GetCurrentPage()) do
        local team = Instance.new("Team")
        team.Name = group.Name
        team.TeamColor = BrickColor.random()
        team.Parent = Teams
        teams[group.Id] = team
    end
    if allies.IsFinished then
        break
    end
    allies:AdvanceToNextPageAsync()
end

Players.PlayerAdded:Connect(function(player)
    for id, team in pairs(teams) do
        if player:IsInGroup(id) then
            player.Team = team
        end
    end
    if not player.Team then
        player.Team = wastelanders
    end
end)