local GameState = {}

function GameState.new()
    return {
        -- Progresión
        day = 1,
        actionsRemaining = 2,

        -- Estadísticas del jugador
        stats = {
            charm = 0,
            confidence = 0,
            energy = 5
        },

        -- Colección de cartas
        collection = {},
        nextCardId = 1,
        feedback = {
            message = "Bienvenido a Snake Date"
        }
    }
end

return GameState
