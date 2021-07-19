local Class = require(script.Parent.Class)
local Event = Class() do
	function Event:init()
		self._connections = {}
		self._destroyed = false
		self._firing = false
		self._bindable = Instance.new("BindableEvent")
		return self
	end

	function Event:Fire(...)
		--local connections = self._connections
		self._args = {...}
		self._numArgs = select("#", ...)
		self._bindable:Fire()
	end

	function Event:Wait()
		self._bindable.Event:Wait()
		return unpack(self._args, 1, self._numArgs)
	end

	function Event:Connect(func)
		assert(not self._destroyed, "Cannot connect to destroyed event")
		assert(type(func) == "function", "Argument must be function")
		return self._bindable.Event:Connect(function()
			func(unpack(self._args, 1, self._numArgs))
		end)
	end

	function Event:DisconnectAll()
		self._bindable:Destroy()
		self._bindable = Instance.new("BindableEvent")
	end

	function Event:Destroy()
		if self._destroyed then return end
		self._destroyed = true
		self._bindable:Destroy()
	end
end

return setmetatable({ new = Event }, {
    __call = function (_, ...)
        return Event(...)
    end
})

