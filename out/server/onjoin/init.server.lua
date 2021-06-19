local Players = game:GetService("Players")
local autoteam = require(script.autoteam)
local nametag = require(script.nametag)

function init()
    autoteam.removeTeams()
    autoteam.generateTeams()
    for _, player in pairs(Players:GetPlayers()) do
        onJoin(player)
    end
end

function onJoin(player)
    autoteam.assignTeam(player)
    nametag(player)
end

Players.PlayerAdded:Connect(onJoin)

script.reloadteams.Event:Connect(init)

init()