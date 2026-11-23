local SceneManager = require("src.scenes.SceneManager")
local ProgressionSystem = require("src.systems.ProgressionSystem")
local ProgressionUI = require("src.ui.ProgressionUI")

local ProgressionScene = {}

function ProgressionScene:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.gameState.feedback.message = "¿Que deseas hacer hoy?"

    self.ui = ProgressionUI.new()
    self.ui:setup(gameState, eventBus)
end

function ProgressionScene:update(dt)
    local canAdvance =
        ProgressionSystem.can_advance(self.gameState)

    self.ui:update(dt, canAdvance)
end

function ProgressionScene:perform_action(action, index)
    -- Actualizar la seleccion visual.
    self.ui:set_selected(index)

    local success, message =
        ProgressionSystem.perform_action(self.gameState, action)

    if success then
        self.eventBus:emit("action_performed", {
            action = action,
            message = message
        })

        print(message)
    else
        self.gameState.feedback.message = message
    end
end

function ProgressionScene:render()
    self.ui:render()
end

function ProgressionScene:keypressed(key)
    if key == "1" then
        self:perform_action("compliments", 1)

    elseif key == "2" then
        self:perform_action("garden", 2)

    elseif key == "3" then
        self:perform_action("rest", 3)

    elseif key == "return" then
        if ProgressionSystem.can_advance(self.gameState) then
            local CardAcquisitionScene =
                require("src.scenes.CardAcquisitionScene")

            SceneManager.change(CardAcquisitionScene)
        end

    elseif key == "escape" then
        local MapScene = require("src.scenes.MapScene")
        SceneManager.change(MapScene)
    end
end

return ProgressionScene