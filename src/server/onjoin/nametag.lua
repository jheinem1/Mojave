-- THIS SCRIPT WAS CREATED WITH ROJO; ANY CHANGES MADE IN STUDIO WILL BE OVERWRITTEN

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Roact = require(ReplicatedStorage.Vendor.Roact)
local allies = require(ServerScriptService.Server.allies)
local mainGroup = 4978642

function nametag(props)
    return Roact.createElement("BillboardGui",
        {
            Name = "Nametag",
            Size = UDim2.fromScale(4, 1.5),
            StudsOffset = Vector3.new(0, 3.5, 0),
            MaxDistance = 60,
            LightInfluence = 0
        },
        {
            Roact.createElement("TextLabel",
                {
                    Name = "Name",
                    Position = UDim2.new(0, 5, 0, 0),
                    Size = UDim2.new(1, -10, 0.5, 0),
                    ZIndex = 2,
                    BackgroundTransparency = 1,
                    TextColor3 = props.color,
                    Font = Enum.Font.SourceSansBold,
                    TextScaled = true,
                    Text = props.name
                }
            ),
            Roact.createElement("TextLabel",
                {
                    Name = "Team",
                    Position = UDim2.new(0, 5, 0.5, 0),
                    Size = UDim2.new(1, -10, 0.25, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = props.color,
                    Font = Enum.Font.SourceSansBold,
                    TextScaled = true,
                    Text = props.team
                }
            ),
            Roact.createElement("TextLabel",
                {
                    Name = "Rank",
                    Position = UDim2.new(0, 5, 0.75, 0),
                    Size = UDim2.new(1, -10, 0.25, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = props.color,
                    Font = Enum.Font.SourceSansBold,
                    TextScaled = true,
                    Text = props.rank
                }
            )
        }
    )
end

function addNametag(player: Player)
    local team = player.Team
    assert(team, "No team assigned!")
    local group
    for _, ally in pairs(allies) do
        if team.Name == ally.Name then
            group = ally
        end
    end
    local rank
    if player:GetRankInGroup(mainGroup) >= 20 or not group then
        rank = player:GetRoleInGroup(mainGroup)
    else
        rank = player:GetRoleInGroup(group.Id)
    end
    player.CharacterAdded:Connect(function(character)
        Roact.mount(nametag(
            {
                name = player.DisplayName,
                team = team.Name,
                rank = rank,
                color = team.TeamColor.Color
            }),
            character.HumanoidRootPart
        )
    end)
end

return addNametag