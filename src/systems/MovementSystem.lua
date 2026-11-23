local CollisionSystem = require("src.systems.CollisionSystem")

local MovementSystem = {}

function MovementSystem.update(world, dt, mapWidth, mapHeight, map)
    local movingEntities = world:query(
        "Transform",
        "Velocity",
        "Circle",
        "Player"
    )

    for _, entity in ipairs(movingEntities) do
        local transform = world:get_component(
            entity,
            "Transform"
        )

        local velocity = world:get_component(
            entity,
            "Velocity"
        )

        local circle = world:get_component(
            entity,
            "Circle"
        )

        local radius = circle.radius

        -- Movimiento horizontal
        local previousX = transform.x

        transform.x = transform.x + velocity.vx * dt

        transform.x = math.max(
            radius,
            math.min(transform.x, mapWidth - radius)
        )

        if CollisionSystem.check_player_collision(world, map) then
            transform.x = previousX
        end

        -- Movimiento vertical
        local previousY = transform.y

        transform.y = transform.y + velocity.vy * dt

        transform.y = math.max(
            radius,
            math.min(transform.y, mapHeight - radius)
        )

        if CollisionSystem.check_player_collision(world, map) then
            transform.y = previousY
        end
    end
end

return MovementSystem