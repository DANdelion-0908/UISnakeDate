local ProgressionUI = {}

function ProgressionUI.new()
    return setmetatable({}, {__index = ProgressionUI})
end

function ProgressionUI:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.selectedAction = 1
    self.canAdvance = false

    self.displayData = {
        day = 1,
        actions = 0,
        charm = 0,
        confidence = 0,
        energy = 0,
        message = ""
    }

    self.actions = {
        {
            id = "compliments",
            title = "Practicar cumplidos",
            description = "+2 Encanto, -1 Energia"
        },
        {
            id = "garden",
            title = "Pasear por el jardin",
            description = "+2 Confianza, -1 Energia"
        },
        {
            id = "rest",
            title = "Descansar",
            description = "+2 Energia"
        }
    }

    self.layout = {
        panelX = 150,
        panelY = 185,
        panelWidth = 500,
        panelHeight = 65,
        panelGap = 12
    }
end

function ProgressionUI:update(dt, canAdvance)
    local stats = self.gameState.stats

    -- Sincronizar los datos visibles con el estado de juego.
    self.displayData.day = self.gameState.day
    self.displayData.actions = self.gameState.actionsRemaining

    self.displayData.charm = stats.charm
    self.displayData.confidence = stats.confidence
    self.displayData.energy = stats.energy

    self.displayData.message = self.gameState.feedback.message

    self.canAdvance = canAdvance
end

function ProgressionUI:set_selected(index)
    if index >= 1 and index <= #self.actions then
        self.selectedAction = index
    end
end

function ProgressionUI:render()
    local data = self.displayData
    local layout = self.layout

    love.graphics.clear(0.12, 0.16, 0.20)

    love.graphics.setColor(1, 1, 1)

    -- Titulo.
    love.graphics.printf(
        "ENTRENAMIENTO",
        0, 35, 800, "center"
    )

    -- Informacion del dia.
    love.graphics.printf(
        "Dia: " .. data.day,
        0, 85, 800, "center"
    )

    love.graphics.printf(
        "Acciones restantes: " .. data.actions,
        0, 115, 800, "center"
    )

    -- Estadisticas.
    love.graphics.printf(
        "Encanto: " .. data.charm,
        0, 155, 260, "center"
    )

    love.graphics.printf(
        "Confianza: " .. data.confidence,
        270, 155, 260, "center"
    )

    love.graphics.printf(
        "Energia: " .. data.energy,
        540, 155, 260, "center"
    )

    -- Opciones de entrenamiento.
    for index, action in ipairs(self.actions) do
        local y = layout.panelY
            + (index - 1) * (layout.panelHeight + layout.panelGap)

        if index == self.selectedAction then
            love.graphics.setColor(0.25, 0.45, 0.32)
        else
            love.graphics.setColor(0.20, 0.25, 0.29)
        end

        love.graphics.rectangle(
            "fill",
            layout.panelX,
            y,
            layout.panelWidth,
            layout.panelHeight,
            8,
            8
        )

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            index .. " - " .. action.title,
            layout.panelX,
            y + 10,
            layout.panelWidth,
            "center"
        )

        love.graphics.printf(
            action.description,
            layout.panelX,
            y + 34,
            layout.panelWidth,
            "center"
        )
    end

    -- Mensaje de estado.
    love.graphics.setColor(1, 0.9, 0.65)

    love.graphics.printf(
        data.message,
        50, 445, 700, "center"
    )

    love.graphics.setColor(1, 1, 1)

    if self.canAdvance then
        love.graphics.printf(
            "ENTER - Continuar a la adquisicion de cartas",
            50, 510, 700, "center"
        )
    else
        love.graphics.printf(
            "Selecciona una actividad con las teclas 1, 2 o 3",
            50, 510, 700, "center"
        )
    end

    love.graphics.printf(
        "ESC - Regresar al mapa",
        0, 565, 800, "center"
    )

    love.graphics.setColor(1, 1, 1)
end

return ProgressionUI