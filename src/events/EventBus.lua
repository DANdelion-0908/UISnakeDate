local EventBus = {}
EventBus.__index = EventBus

function EventBus.new()
    local instance = {
        listeners = {}
    }

    return setmetatable(instance, EventBus)
end

function EventBus:on(eventName, callback)
    assert(type(callback) == "function",
        "El listener debe ser una funcion")

    if not self.listeners[eventName] then
        self.listeners[eventName] = {}
    end

    table.insert(self.listeners[eventName], callback)
end

function EventBus:emit(eventName, data)
    local listeners = self.listeners[eventName]

    if not listeners then
        return
    end

    for _, callback in ipairs(listeners) do
        callback(data)
    end
end

return EventBus