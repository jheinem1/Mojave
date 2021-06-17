local GroupService = game:GetService("GroupService")

local allyPages = GroupService:GetAlliesAsync(4978642)
local allies = {}
while true do
    for _, group in pairs(allyPages:GetCurrentPage()) do
        table.insert(allies, group)
    end
    if allyPages.IsFinished then
        break
    end
    allyPages:AdvanceToNextPageAsync()
end

return allies