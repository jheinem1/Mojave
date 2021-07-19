--// File Name: Modules
--// Creator: Rythian Smythe / Rythian2277
--// Date: July 14, 2021

return function(moduleName)
    local PathToFollow = string.split(moduleName, "/")
    local currentInstance = script
    for _, objectName in ipairs(PathToFollow) do
        if currentInstance:FindFirstChild(objectName) then
            currentInstance = currentInstance:FindFirstChild(objectName)
        end
    end
    if currentInstance:IsA("ModuleScript") then
        return require(currentInstance)
    else
        return error(string.format("Module %s does not exist, this may be due to incorrect spelling or a development oversight.", currentInstance.Name))
    end
end