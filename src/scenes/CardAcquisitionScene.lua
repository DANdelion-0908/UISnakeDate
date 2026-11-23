local SceneManager = require("src.scenes.SceneManager")

local CardGenerator = require("src.systems.CardGenerator")
local CollectionSystem = require("src.systems.CollectionSystem")

local ProgressionSystem = require("src.systems.ProgressionSystem")

local CardAcquisitionScene = {}

function CardAcquisitionScene:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.offers = CardGenerator.generate(gameState, 3)
    self.selectedIndex = 1

    self.acquired = false

    self.gameState.feedback.message = "Selecciona una carta con las teclas 1, 2 o 3"
end

function CardAcquisitionScene:update(dt)
end

function CardAcquisitionScene:render()
    love.graphics.clear(0.12, 0.16, 0.20)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "ADQUISICION DE CARTAS",
        0, 35, 800, "center"
    )

    love.graphics.printf(
        "Tus estadisticas influyen en las cartas que aparecen.",
        0, 75, 800, "center"
    )

    for i, card in ipairs(self.offers) do
        local x = 65 + (i - 1) * 245
        local y = 170
        local width = 215
        local height = 260

        if i == self.selectedIndex then
            love.graphics.setColor(0.85, 0.72, 0.35)
        else
            love.graphics.setColor(0.3, 0.34, 0.40)
        end

        love.graphics.rectangle(
            "fill", x, y, width, height, 10, 10
        )

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            tostring(i) .. " - " .. card.name,
            x + 10, y + 20, width - 20, "center"
        )

        love.graphics.printf(
            card.category,
            x + 10, y + 75, width - 20, "center"
        )

        love.graphics.printf(
            card.description,
            x + 15, y + 115, width - 30, "center"
        )

        love.graphics.printf(
            "Valor: " .. card.value,
            x + 10, y + 205, width - 20, "center"
        )
    end

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        self.gameState.feedback.message,
        0, 470, 800, "center"
    )

    love.graphics.printf(
        "ENTER - Obtener carta seleccionada",
        0, 520, 800, "center"
    )

    love.graphics.printf(
        "ESC - Volver al entrenamiento",
        0, 555, 800, "center"
    )
end

function CardAcquisitionScene:acquire_selected_card()
    local selectedCard = self.offers[self.selectedIndex]

    if not selectedCard then
        return
    end

    local acquiredCard = CollectionSystem.add_card(
        self.gameState,
        selectedCard
    )

    self.message = "Obtuviste: " .. acquiredCard.name

    print("Carta obtenida:", acquiredCard.name)
    print("Total de cartas:", #self.gameState.collection)

    -- Notificamos que se obtuvo una carta.
    self.eventBus:emit("card_acquired", acquiredCard)

    -- Comienza el siguiente día.
    ProgressionSystem.advance_day(self.gameState)

    self.acquired = true
end

function CardAcquisitionScene:keypressed(key)
    if self.acquired then
        if key == "return" then
            local MapScene = require("src.scenes.MapScene")
            SceneManager.change(MapScene)
        end

        return
    end

    if key == "1" then
        self.selectedIndex = 1

    elseif key == "2" then
        self.selectedIndex = 2

    elseif key == "3" then
        self.selectedIndex = 3

    elseif key == "return" then
        self:acquire_selected_card()

    elseif key == "escape" then
        local ProgressionScene =
            require("src.scenes.ProgressionScene")

        SceneManager.change(ProgressionScene)
    end
end

return CardAcquisitionScene