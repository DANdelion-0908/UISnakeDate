local World = {}
World.__index = World

function World.new()
    local self = setmetatable({}, World)

    self.nextEntity = 1
    self.entities = {}
    self.components = {}

    return self
end

function World:create_entity()
    local entity = self.nextEntity

    self.nextEntity = self.nextEntity + 1
    self.entities[entity] = true

    return entity
end

function World:destroy_entity(entity)
    if not self.entities[entity] then
        return
    end

    for _, componentPool in pairs(self.components) do
        componentPool[entity] = nil
    end

    self.entities[entity] = nil
end

function World:add_component(entity, componentName, data)
    assert(self.entities[entity], "Invalid entity")

    if not self.components[componentName] then
        self.components[componentName] = {}
    end

    self.components[componentName][entity] = data
end

function World:get_component(entity, componentName)
    local pool = self.components[componentName]

    if not pool then
        return nil
    end

    return pool[entity]
end

function World:has_component(entity, componentName)
    return self:get_component(entity, componentName) ~= nil
end

function World:remove_component(entity, componentName)
    local pool = self.components[componentName]

    if pool then
        pool[entity] = nil
    end
end

function World:query(...)
    local componentNames = {...}
    local results = {}

    for entity in pairs(self.entities) do
        local matches = true

        for _, componentName in ipairs(componentNames) do
            if not self:has_component(entity, componentName) then
                matches = false
                break
            end
        end

        if matches then
            table.insert(results, entity)
        end
    end

    return results
end

return World