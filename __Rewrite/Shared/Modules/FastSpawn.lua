local Event = require(script.Parent.Event)

return function(callback)
    local _Trigger = Event()
    _Trigger:Connect(callback)
    _Trigger:Fire()
end