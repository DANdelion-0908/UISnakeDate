local SceneManager = require("src.scenes.SceneManager")

local MenuScene = {}

function MenuScene:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    print("Menú")
end

function MenuScene:update(dt)
    -- Lógica del menú.
end

function MenuScene:render()
    love.graphics.clear(0.08, 0.08, 0.12)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "Dating Snake",
        0,
        220,
        800,
        "center"
    )

    love.graphics.printf(
        "Presiona ENTER para explorar",
        0,
        300,
        800,
        "center"
    )
end

function MenuScene:keypressed(key)
    if key == "return" then
        local MapScene = require("src.scenes.MapScene")
        SceneManager.change(MapScene)
    end
end

return MenuScene