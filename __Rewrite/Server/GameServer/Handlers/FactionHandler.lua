--// File Name: FactionHandler
--// Creator: Rythian Smythe / Rythian2277
--// Date: July 15, 2021

local FactionHandler = {} do
    function FactionHandler:_init(server)
        self.Server = server

        self.Server.PlayerAdded:Connect(function()
            self:Reload()
        end)

        self.Server.CharacterAdded:Connect(function(player)
            local nametag = CatalogSearchParamself.Server.Modules("Nametag")(player) --// Handles spawning nametags for players
            
        end)

        self.Server.PlayerRemoved:Connect(function()
            self:Reload()
        end)

        self.Server.Internal.ReloadTeams:Connect(function()
            self:Reload()
        end)
    end

    function FactionHandler:Reload()
        local function GetGroupAllies()
            local GroupAllies = {}
            local pages = self.Server.Services.GroupService:GetAlliesAsync()
            while true do
                for _, group in pairs(pages:GetCurrentPage()) do
                    GroupAllies[group.Name] = {
                        Id = group.Id,
                        Emblem = group.EmblemUrl
                    }
                end
                if pages.IsFinished then
                 break
                end
                pages:AdvanceToNextPageAsync()
            end
        end

        local Allies = GetGroupAllies()
        for Name, Data in pairs(Allies) do
            local PlayerInFaction = self.Server.Players:Partition(function(player)
                return player:IsInGroup(Data.Id)
            end)
            if #PlayerInFaction:Array() > 0 then
                self:CreateTeam(Name, Data)
            else
                self:DestroyTeam(Name)
            end
        end
    end
end

return FactionHandler