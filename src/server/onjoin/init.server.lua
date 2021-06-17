local Players = game:GetService("Players")
-- local children = script:GetChildren()
-- local functions = {}

-- for _, child in pairs(children) do
--     table.insert(functions, require(child))
-- end

function onJoin(player)
    require(script.autoteam)(player)
    require(script.nametag)(player)
end

Players.PlayerAdded:Connect(onJoin)

for _, player in pairs(Players:GetPlayers()) do
    onJoin(player)
end