-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local ServerScriptService = game:GetService("ServerScriptService")
local teams = {}
local wastelanders = Instance.new("Team")
local allies = require(ServerScriptService.Server.allies)
local usedColors = {}
local current = 0
local customColorPattern = "Color: '([%a ]+)'"

wastelanders.Name = "Wastelanders"
wastelanders.TeamColor = BrickColor.Gray()
wastelanders.Parent = Teams

for _, group in pairs(allies) do
    local customColor = string.match(group.Description, customColorPattern)
    local color
    if customColor and not usedColors[BrickColor.new(customColor).Number] then
        color = BrickColor.new(customColor)
    else
        while current < 1032 do
            current += 1
            color = BrickColor.new(current)
            if not usedColors[color.Number] then
                usedColors[color.Number] = true
                break
            end
        end
    end
    assert(current < 1032, "Out of colors")

    local team = Instance.new("Team")
    team.Name = group.Name
    team.TeamColor = color
    team.Parent = Teams
    teams[group.Id] = team
end

function assignTeam(player)
    for id, team in pairs(teams) do
        if player:IsInGroup(id) then
            player.Team = team
            return
        end
    end
    player.Team = wastelanders
end

Players.PlayerAdded:Connect(assignTeam)

for _, player in pairs(Players:GetPlayers()) do
    assignTeam(player)
end