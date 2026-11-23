local SceneManager = {}

local currentScene = nil
local gameState = nil
local eventBus = nil

function SceneManager.initialize(state, bus)
    gameState = state
    eventBus = bus
end

function SceneManager.change(scene)
    if currentScene and currentScene.exit then
        currentScene:exit()
    end

    currentScene = scene

    if currentScene and currentScene.setup then
        currentScene:setup(gameState, eventBus)
    end
end

function SceneManager.update(dt)
    if currentScene and currentScene.update then
        currentScene:update(dt)
    end
end

function SceneManager.render()
    if currentScene and currentScene.render then
        currentScene:render()
    end
end

function SceneManager.keypressed(key)
    if currentScene and currentScene.keypressed then
        currentScene:keypressed(key)
    end
end

return SceneManager