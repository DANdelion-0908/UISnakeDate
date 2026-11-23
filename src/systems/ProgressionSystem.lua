local ProgressionSystem = {}

function ProgressionSystem.perform_action(gameState, action)
    if gameState.actionsRemaining <= 0 then
        return false, "No quedan acciones disponibles"
    end

    local stats = gameState.stats

    if action == "compliments" then
        if stats.energy < 1 then
            return false, "No tienes suficiente energia"
        end

        stats.charm = stats.charm + 2
        stats.energy = stats.energy - 1

    elseif action == "garden" then
        if stats.energy < 1 then
            return false, "No tienes suficiente energia"
        end

        stats.confidence = stats.confidence + 2
        stats.energy = stats.energy - 1

    elseif action == "rest" then
        stats.energy = stats.energy + 2

    else
        return false, "Accion desconocida"
    end

    gameState.actionsRemaining = gameState.actionsRemaining - 1

    return true, "Accion realizada correctamente"
end

function ProgressionSystem.can_advance(gameState)
    return gameState.actionsRemaining <= 0
end

function ProgressionSystem.advance_day(gameState)
    if not ProgressionSystem.can_advance(gameState) then
        return false
    end

    gameState.day = gameState.day + 1
    gameState.actionsRemaining = 2

    return true
end

return ProgressionSystem