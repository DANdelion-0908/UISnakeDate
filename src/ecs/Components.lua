local Components = {}

function Components.Transform(x, y)
    return {
        x = x,
        y = y
    }
end

function Components.Velocity(vx, vy)
    return {
        vx = vx,
        vy = vy
    }
end

function Components.Circle(radius)
    return {
        radius = radius
    }
end

function Components.Player()
    return {}
end

return Components