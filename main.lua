local SceneManager = require("src.scenes.SceneManager")
local MenuScene = require("src.scenes.MenuScene")

local GameState = require("src.state.GameState")
local EventBus = require("src.events.EventBus")

local FeedbackSystem = require("src.systems.FeedbackSystem")

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Dating Snake")

    local gameState = GameState.new()
    local eventBus = EventBus.new()

    FeedbackSystem.initialize(eventBus, gameState)

    SceneManager.initialize(gameState, eventBus)
    SceneManager.change(MenuScene)
end

function love.update(dt)
    SceneManager.update(dt)
end

function love.draw()
    SceneManager.render()
end

function love.keypressed(key)
    SceneManager.keypressed(key)
end