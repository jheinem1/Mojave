--// File Name: Server.server
--// Creator: Rythian Smythe / Rythian2277
--// Date: July 14, 2021

local Shared = game:GetService("ReplicatedStorage")
local Modules = require(Shared.Modules)

local Services = {
    Players = game:GetService("Players"),
    Http = game:GetService("HttpService"),
    --// Input ReplicatedStorage as its common use name of "Shared" for ease of access
    ReplicatedStorage = Shared,
    Shared = Shared
}

local Server = {
    Services = Services,
    Modules = Modules,

    --// Special Holder Objects
    Players = Modules("Collection")(),

    --// Server Broadcasted Events
    PlayerAdded = Modules("Event")(), --// Player: Player
    PlayerRemoved = Modules("Event")(), --// Player: Player
    CharacterAdded = Modules("Event")(), --// Player: Player, Character: Model
    PlayerChangedTeam = Modules("Event")(), --// Player: Player, OldTeam: Team, NewTeam: Team
    PlayerEnteredZone = Modules("Event")(), --// Player: Player, Zone: ZoneData

    Internal = {
        ReloadTeams = Modules("Event")(), --// VOID // When fired, will reload all teams and re-team all players
        Broadcast = Modules("Event")(), --// Command: String // Will be used for cross-handler communication for when multiple handlers need to work together.
    }
} do
    function Server:_Start()
        --// Players Service Event Connections

        for _, handler in ipairs(script.Handlers:GetChildren()) do
            local _module = require(handler)
            Modules("FastSpawn")(function()
                _module:_init(self) --// This lets the handler get access to the server functions and permissions.
            end)
        end

        local function PlayerJoined(player)
            if player.AccountAge < 7 then --// Age checking
                player.Kick("Your account must be at least a week old in order to play.")
            else --// If the player passes checks, let the game continue processing them however it needs to.
                self.PlayerAdded:Fire(player)
                player.CharacterAdded:Connect(function(character)
                    self.CharacterAdded:Fire(player, character)
                end)
            end
        end

        self.Services.Players.PlayerAdded:Connect(PlayerJoined)
        self.Services.Players.PlayerRemoving:Connect(function(player)
            self.PlayerRemoved:Fire(player)
        end)
        for _, player in ipairs(self.Services.Players:GetPlayers()) do
            PlayerJoined(player)
        end
    end

    Server.Util = {} do
        function Server.Util:CleanString(str: string): string
            local new = ""
            for _, argument in ipairs(string.split(str, " ")) do
                new ..= string.gsub(argument, "[%p%c]", "") .. " "
            end
            return string.sub(new, 1, string.len(new)-1)
        end
    end
end

Server:_Start()
return Server