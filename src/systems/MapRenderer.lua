local MapRenderer = {}

local function draw_paths(paths)
    love.graphics.setColor(0.55, 0.40, 0.25)

    for _, path in ipairs(paths) do
        love.graphics.rectangle(
            "fill",
            path.x,
            path.y,
            path.width,
            path.height
        )
    end
end

local function draw_obstacles(obstacles)
    for _, obstacle in ipairs(obstacles) do
        -- Tronco o base
        love.graphics.setColor(0.35, 0.20, 0.10)

        love.graphics.circle(
            "fill",
            obstacle.x,
            obstacle.y,
            obstacle.radius
        )

        -- Copa del árbol o roca
        love.graphics.setColor(0.10, 0.30, 0.12)

        love.graphics.circle(
            "fill",
            obstacle.x,
            obstacle.y - 8,
            obstacle.radius
        )
    end
end

local function draw_points_of_interest(points)
    for _, point in ipairs(points) do
        love.graphics.setColor(point.color)

        love.graphics.rectangle(
            "fill",
            point.x,
            point.y,
            point.width,
            point.height,
            12,
            12
        )

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            point.name,
            point.x - 20,
            point.y + point.height + 5,
            point.width + 40,
            "center"
        )
    end
end

function MapRenderer.draw(mapData)
    -- Terreno
    love.graphics.setColor(mapData.background.color)

    love.graphics.rectangle(
        "fill",
        0,
        0,
        mapData.width,
        mapData.height
    )

    draw_paths(mapData.paths)
    draw_points_of_interest(mapData.pointsOfInterest)
    draw_obstacles(mapData.obstacles)

    -- Límites visuales del mapa
    love.graphics.setColor(0.08, 0.18, 0.08)

    love.graphics.rectangle(
        "line",
        0,
        0,
        mapData.width,
        mapData.height
    )
end

return MapRenderer