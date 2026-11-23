local InputSystem = {}

function InputSystem.update(world)
    local players = world:query(
        "Player",
        "Velocity"
    )

    local directionX = 0
    local directionY = 0

    if love.keyboard.isDown("a") or
       love.keyboard.isDown("left") then
        directionX = directionX - 1
    end

    if love.keyboard.isDown("d") or
       love.keyboard.isDown("right") then
        directionX = directionX + 1
    end

    if love.keyboard.isDown("w") or
       love.keyboard.isDown("up") then
        directionY = directionY - 1
    end

    if love.keyboard.isDown("s") or
       love.keyboard.isDown("down") then
        directionY = directionY + 1
    end

    for _, entity in ipairs(players) do
        local velocity = world:get_component(
            entity,
            "Velocity"
        )

        local length = math.sqrt(
            directionX * directionX +
            directionY * directionY
        )

        if length > 0 then
            directionX = directionX / length
            directionY = directionY / length
        end

        local speed = 180

        velocity.vx = directionX * speed
        velocity.vy = directionY * speed
    end
end

return InputSystem