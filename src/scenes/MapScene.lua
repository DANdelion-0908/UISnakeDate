local SceneManager = require("src.scenes.SceneManager")

local MapData = require("src.scenes.MapData")
local MapRenderer = require("src.systems.MapRenderer")

local World = require("src.ecs.World")
local Factory = require("src.entities.Factory")

local InputSystem = require("src.systems.InputSystem")
local MovementSystem = require("src.systems.MovementSystem")
local RenderSystem = require("src.systems.RenderSystem")

local HUDUI = require("src.ui.HUDUI")

local DialogueUI = require("src.ui.DialogueUI")
local DialogueData = require("src.scenes.DialogueData")

local MapScene = {}

local function get_distance_to_rectangle(x, y, rectangle)
    local closestX = math.max(
        rectangle.x,
        math.min(x, rectangle.x + rectangle.width)
    )

    local closestY = math.max(
        rectangle.y,
        math.min(y, rectangle.y + rectangle.height)
    )

    local dx = x - closestX
    local dy = y - closestY

    return math.sqrt(dx * dx + dy * dy)
end

function MapScene:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus
    self.map = MapData
    self.world = World.new()

    self.nearbyPoint = nil

    self.hud = HUDUI.new()
    self.hud:setup(self.gameState, self.eventBus)

    self.dialogueUI = DialogueUI.new()
    self.dialogueUI:setup(self.gameState, self.eventBus)

    Factory.create_player(
        self.world,
        400,
        300
    )

    print("Dia actual:", self.gameState.day)
    print("Acciones disponibles:", self.gameState.actionsRemaining)
    print("Energia:", self.gameState.stats.energy)
    print("Estado compartido:", self.gameState ~= nil)
end


function MapScene:update(dt)
    dt = math.min(dt, 1 / 30)

    -- El jugador no puede moverse mientras conversa.
    if not self.dialogueUI:is_active() then
        InputSystem.update(self.world)

        MovementSystem.update(
            self.world,
            dt,
            self.map.width,
            self.map.height,
            self.map
        )
    end

    self.nearbyPoint = nil

    local players = self.world:query(
        "Player",
        "Transform"
    )

    for _, entity in ipairs(players) do
        local transform = self.world:get_component(
            entity,
            "Transform"
        )

        for _, point in ipairs(self.map.pointsOfInterest) do
            local distance = get_distance_to_rectangle(
                transform.x,
                transform.y,
                point
            )

            if distance <= 45 then
                self.nearbyPoint = point
                break
            end
        end
    end

    self.hud:update(dt, self.nearbyPoint)
    self.dialogueUI:update(dt)
end

function MapScene:render()
    MapRenderer.draw(self.map)
    RenderSystem.draw(self.world)

    self.hud:render()
    self.dialogueUI:render()
end

function MapScene:keypressed(key)
    if self.dialogueUI:is_active() then
        self.dialogueUI:keypressed(key)
        return
    end

    if key == "e" then
        if self.nearbyPoint and self.nearbyPoint.dialogueId then
            local dialogue = DialogueData[
                self.nearbyPoint.dialogueId
            ]

            self.dialogueUI:start(dialogue)
        end

        return
    end

    if key == "escape" then
        local MenuScene = require("src.scenes.MenuScene")
        SceneManager.change(MenuScene)

    elseif key == "p" then
        local ProgressionScene =
            require("src.scenes.ProgressionScene")

        SceneManager.change(ProgressionScene)

    elseif key == "c" then
        local CollectionScene =
            require("src.scenes.CollectionScene")

        SceneManager.change(CollectionScene)
    end
end

return MapScene