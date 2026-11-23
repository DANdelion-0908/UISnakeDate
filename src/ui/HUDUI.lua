local HUDUI = {}

function HUDUI.new()
    return setmetatable({}, {__index = HUDUI})
end

function HUDUI:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.nearbyPoint = nil

    self.layout = {
        panelX = 15,
        panelY = 15,
        panelWidth = 265,
        panelHeight = 125,

        controlsX = 560,
        controlsY = 15,

        messageX = 220,
        messageY = 535,
        messageWidth = 360,
        messageHeight = 40
    }

    self.displayData = {
        day = 1,
        actions = 0,
        charm = 0,
        confidence = 0,
        energy = 0
    }
end

function HUDUI:update(dt, nearbyPoint)
    self.nearbyPoint = nearbyPoint

    -- Actualizar los datos visibles desde el estado de juego.
    self.displayData.day = self.gameState.day
    self.displayData.actions = self.gameState.actionsRemaining

    self.displayData.charm = self.gameState.stats.charm
    self.displayData.confidence = self.gameState.stats.confidence
    self.displayData.energy = self.gameState.stats.energy
end

function HUDUI:render()
    local layout = self.layout
    local data = self.displayData

    -- Panel principal.
    love.graphics.setColor(0, 0, 0, 0.75)

    love.graphics.rectangle(
        "fill",
        layout.panelX,
        layout.panelY,
        layout.panelWidth,
        layout.panelHeight,
        8,
        8
    )

    -- Información de la partida.
    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Día: " .. data.day,
        layout.panelX + 12,
        layout.panelY + 10
    )

    love.graphics.print(
        "Acciones restantes: " .. data.actions,
        layout.panelX + 12,
        layout.panelY + 32
    )

    love.graphics.print(
        "Encanto: " .. data.charm,
        layout.panelX + 12,
        layout.panelY + 58
    )

    love.graphics.print(
        "Confianza: " .. data.confidence,
        layout.panelX + 12,
        layout.panelY + 78
    )

    love.graphics.print(
        "Energía: " .. data.energy,
        layout.panelX + 12,
        layout.panelY + 98
    )

    -- Controles.
    love.graphics.setColor(0, 0, 0, 0.65)

    love.graphics.rectangle(
        "fill",
        layout.controlsX,
        layout.controlsY,
        225,
        105,
        8,
        8
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "WASD / Flechas: Moverse",
        layout.controlsX + 10,
        layout.controlsY + 10
    )

    love.graphics.print(
        "P: Entrenamiento",
        layout.controlsX + 10,
        layout.controlsY + 32
    )

    love.graphics.print(
        "C: Colección",
        layout.controlsX + 10,
        layout.controlsY + 54
    )

    love.graphics.print(
        "ESC: Menú",
        layout.controlsX + 10,
        layout.controlsY + 76
    )

-- Indicador de interacción cercana.
    if self.nearbyPoint then
        love.graphics.setColor(0, 0, 0, 0.75)

        love.graphics.rectangle(
            "fill",
            layout.messageX,
            layout.messageY,
            layout.messageWidth,
            layout.messageHeight,
            8,
            8
        )

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            self.nearbyPoint.interactionLabel
                or ("Zona cercana: " .. self.nearbyPoint.name),
            layout.messageX,
            layout.messageY + 12,
            layout.messageWidth,
            "center"
        )
    end

    -- Restablecer el color para otros elementos gráficos.
    love.graphics.setColor(1, 1, 1)
end

return HUDUI