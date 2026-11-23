local SceneManager = require("src.scenes.SceneManager")
local CardRenderer = require("src.systems.CardRenderer")

local CollectionScene = {}

local COLUMNS = 3
local CARD_WIDTH = 210
local CARD_HEIGHT = 75
local CARD_GAP = 10
local PAGE_SIZE = 9

function CollectionScene:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.selectedIndex = 1
end

function CollectionScene:update(dt)
    -- No necesita actualizarse por ahora.
end

function CollectionScene:render()
    love.graphics.clear(0.12, 0.16, 0.20)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "MI COLECCION",
        0, 30, 800, "center"
    )

    local collection = self.gameState.collection
    local totalCards = #collection

    love.graphics.printf(
        "Cartas obtenidas: " .. totalCards,
        0, 70, 800, "center"
    )

    if totalCards == 0 then
        love.graphics.printf(
            "Todavia no tienes cartas.",
            0, 230, 800, "center"
        )

        love.graphics.printf(
            "Completa un entrenamiento para conseguir tu primera carta.",
            50, 270, 700, "center"
        )

    else
        local currentPage = math.floor(
            (self.selectedIndex - 1) / PAGE_SIZE
        )

        local firstIndex = currentPage * PAGE_SIZE + 1
        local lastIndex = math.min(
            firstIndex + PAGE_SIZE - 1,
            totalCards
        )

        local startX = 70
        local startY = 120

        for i = firstIndex, lastIndex do
            local card = collection[i]

            local localIndex = i - firstIndex
            local column = localIndex % COLUMNS
            local row = math.floor(localIndex / COLUMNS)

            local x = startX + column * (CARD_WIDTH + CARD_GAP)
            local y = startY + row * (CARD_HEIGHT + CARD_GAP)

            CardRenderer.draw_card(
                card,
                x,
                y,
                CARD_WIDTH,
                CARD_HEIGHT,
                i == self.selectedIndex
            )
        end

        local selectedCard = collection[self.selectedIndex]

        if selectedCard then
            CardRenderer.draw_details(
                selectedCard,
                100,
                390,
                600
            )
        end

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            "Pagina " .. (currentPage + 1) ..
            " de " .. math.ceil(totalCards / PAGE_SIZE),
            0, 365, 800, "center"
        )
    end

    love.graphics.setColor(1, 1, 1)

    -- love.graphics.printf(
    --     "Flechas - Navegar entre cartas",
    --     0, 535, 800, "center"
    -- )

    -- love.graphics.printf(
    --     "ESC - Regresar al mapa",
    --     0, 565, 800, "center"
    -- )
end

function CollectionScene:keypressed(key)
    local totalCards = #self.gameState.collection

    if key == "escape" then
        local MapScene = require("src.scenes.MapScene")
        SceneManager.change(MapScene)
        return
    end

    if totalCards == 0 then
        return
    end

    if key == "right" then
        self.selectedIndex = math.min(
            self.selectedIndex + 1,
            totalCards
        )

    elseif key == "left" then
        self.selectedIndex = math.max(
            self.selectedIndex - 1,
            1
        )

    elseif key == "down" then
        self.selectedIndex = math.min(
            self.selectedIndex + COLUMNS,
            totalCards
        )

    elseif key == "up" then
        self.selectedIndex = math.max(
            self.selectedIndex - COLUMNS,
            1
        )
    end
end

return CollectionScene