local CollisionSystem = {}

-- Círculo contra círculo
local function circle_vs_circle(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y

    local distanceSquared = dx * dx + dy * dy
    local radiusSum = a.radius + b.radius

    return distanceSquared < radiusSum * radiusSum
end

-- Círculo contra rectángulo
local function circle_vs_rectangle(circle, rectangle)
    local closestX = math.max(
        rectangle.x,
        math.min(circle.x, rectangle.x + rectangle.width)
    )

    local closestY = math.max(
        rectangle.y,
        math.min(circle.y, rectangle.y + rectangle.height)
    )

    local dx = circle.x - closestX
    local dy = circle.y - closestY

    local distanceSquared = dx * dx + dy * dy

    return distanceSquared < circle.radius * circle.radius
end

function CollisionSystem.check_player_collision(world, map)
    local players = world:query(
        "Player",
        "Transform",
        "Circle"
    )

    for _, entity in ipairs(players) do
        local transform = world:get_component(entity, "Transform")
        local circle = world:get_component(entity, "Circle")

        local player = {
            x = transform.x,
            y = transform.y,
            radius = circle.radius
        }

        -- Comprobar árboles y rocas
        for _, obstacle in ipairs(map.obstacles) do
            if circle_vs_circle(player, obstacle) then
                return true
            end
        end

        -- Comprobar estanque y otras zonas rectangulares
        for _, area in ipairs(map.solidAreas) do
            if circle_vs_rectangle(player, area) then
                return true
            end
        end
    end

    return false
end

return CollisionSystem