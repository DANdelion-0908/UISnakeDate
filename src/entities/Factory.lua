local Components = require("src.ecs.Components")

local Factory = {}

function Factory.create_player(world, x, y)
    local entity = world:create_entity()

    world:add_component(
        entity,
        "Transform",
        Components.Transform(x, y)
    )

    world:add_component(
        entity,
        "Velocity",
        Components.Velocity(0, 0)
    )

    world:add_component(
        entity,
        "Circle",
        Components.Circle(15)
    )

    world:add_component(
        entity,
        "Player",
        Components.Player()
    )

    return entity
end

return Factory