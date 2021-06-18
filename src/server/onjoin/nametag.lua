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
            MaxDistance = 150,
            LightInfluence = 0,
            Enabled = props.visible
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

function onCharacter(player, character)
    local team = player.Team
    assert(team, "No team assigned!")
    local group
    for _, ally in pairs(allies:getAllies()) do
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
    local nametagProps = {
        name = player.DisplayName,
        team = team.Name,
        rank = rank,
        color = team.TeamColor.Color,
        visible = true
    }
    local nametagHandle = Roact.mount(nametag(nametagProps), character.HumanoidRootPart)
    character.Humanoid.Animator.AnimationPlayed:Connect(function(animation: AnimationTrack)
        if tostring(animation.Animation.AnimationId) == "rbxassetid://6911830449" and nametagProps.visible then
            nametagProps.visible = false
            Roact.update(nametagHandle, nametag(nametagProps))
        elseif not nametagProps.visible then
            nametagProps.visible = true
            Roact.update(nametagHandle, nametag(nametagProps))
        end
    end)
    character.Humanoid.NameDisplayDistance = 0
end

function addNametag(player: Player)
    if player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid:FindFirstChild("Animator") then
        onCharacter(player, player.Character)
    end
    player.CharacterAdded:Connect(function(character)
        onCharacter(player, character)
    end)
end

return addNametag