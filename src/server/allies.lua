local GroupService = game:GetService("GroupService")

local allies = {}

function reload(_: {})
    allies = {}
    local allyPages = GroupService:GetAlliesAsync(4978642)
    while true do
        for _, group in pairs(allyPages:GetCurrentPage()) do
            table.insert(allies, group)
        end
        if allyPages.IsFinished then
            break
        end
        allyPages:AdvanceToNextPageAsync()
    end
end

function getAllies(_: {})
    return allies
end

return { reload = reload, getAllies = getAllies }