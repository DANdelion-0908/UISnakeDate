local RenderSystem = {}

function RenderSystem.draw(world)
    local players = world:query(
        "Player",
        "Transform",
        "Circle"
    )

    for _, entity in ipairs(players) do
        local transform = world:get_component(
            entity,
            "Transform"
        )

        local circle = world:get_component(
            entity,
            "Circle"
        )

        -- Cuerpo de la serpiente
        love.graphics.setColor(0.95, 0.75, 0.25)

        love.graphics.circle(
            "fill",
            transform.x,
            transform.y,
            circle.radius
        )

        -- Cabeza
        love.graphics.setColor(0.85, 0.55, 0.15)

        love.graphics.circle(
            "fill",
            transform.x,
            transform.y - 5,
            circle.radius * 0.75
        )

        -- Ojos
        love.graphics.setColor(0.05, 0.05, 0.05)

        love.graphics.circle(
            "fill",
            transform.x - 5,
            transform.y - 7,
            2
        )

        love.graphics.circle(
            "fill",
            transform.x + 5,
            transform.y - 7,
            2
        )
    end
end

return RenderSystem