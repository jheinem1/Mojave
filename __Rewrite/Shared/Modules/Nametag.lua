return function(player)
    local Character = player.Character
    local Color = Color3.new()
    local Team = ""
    local Rank = ""

    local Billboard = Instance.new("BillboardGui")
    Billboard.Size = UDim2.fromScale(4, 1.5)
    Billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    Billboard.MaxDistance = 150
    Billboard.LightInfluence = 0
    Billboard.Enabled = true

    local TextLabel1 = Instance.new("TextLabel")
    TextLabel1.Name = "PlayerName"
    TextLabel1.Position = UDim2.new(0, 5, 0, 0)
    TextLabel1.Size = UDim2.new(1, -10, 0.5, 0)
    TextLabel1.ZIndex = 2
    TextLabel1.BackgroundTransparency = 1
    TextLabel1.TextColor3 = Color
    TextLabel1.Font = Enum.Font.SourceSansBold
    TextLabel1.TextScaled = true
    TextLabel1.Text = player.Name

    local TextLabel2 = Instance.new("TextLabel")
    TextLabel2.Name = "FactionName"
    TextLabel2.Position = UDim2.new(0, 5, 0.5, 0)
    TextLabel2.Size = UDim2.new(1, -10, 0.25, 0)
    TextLabel2.BackgroundTransparency = 1
    TextLabel2.TextColor3 = Color
    TextLabel2.Font = Enum.Font.SourceSansBold
    TextLabel2.TextScaled = true
    TextLabel2.Text = Team

    local TextLabel3 = Instance.new("TextLabel")
    TextLabel3.Name = "FactionRank"
    TextLabel3.Position = UDim2.new(0, 5, 0.75, 0)
    TextLabel3.Size = UDim2.new(1, -10, 0.25, 0)
    TextLabel3.BackgroundTransparency = 1
    TextLabel3.TextColor3 = Color
    TextLabel3.Font = Enum.Font.SourceSansBold
    TextLabel3.TextScaled = true
    TextLabel3.Text = Rank

    TextLabel1.Parent = Billboard
    TextLabel2.Parent = Billboard
    TextLabel3.Parent = Billboard

    Billboard.Parent = Character.HumanoidRootPart
end