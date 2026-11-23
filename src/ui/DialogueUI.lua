local DialogueUI = {}

local utf8 = require("utf8")

local function utf8_sub(text, first, last)
    local length = utf8.len(text)

    if not length or first > length then
        return ""
    end

    if last >= length then
        return string.sub(text, utf8.offset(text, first))
    end

    local startByte = utf8.offset(text, first)
    local endByte = utf8.offset(text, last + 1)

    return string.sub(text, startByte, endByte - 1)
end

function DialogueUI.new()
    return setmetatable({}, {__index = DialogueUI})
end

function DialogueUI:setup(gameState, eventBus)
    self.gameState = gameState
    self.eventBus = eventBus

    self.active = false
    self.dialogue = nil
    self.currentLine = 1

    self.visibleText = ""
    self.visibleCharacters = 0
    self.characterTimer = 0
    self.charactersPerSecond = 45

    self.layout = {
        x = 50,
        y = 375,
        width = 700,
        height = 185
    }
end

function DialogueUI:start(dialogue)
    if not dialogue or not dialogue.lines then
        return
    end

    self.dialogue = dialogue
    self.currentLine = 1
    self.visibleText = ""
    self.visibleCharacters = 0
    self.characterTimer = 0
    self.active = true

    if self.eventBus then
        self.eventBus:emit("dialogue_started", {
            speaker = dialogue.speaker
        })
    end
end

function DialogueUI:close()
    if not self.active then
        return
    end

    local speaker = self.dialogue.speaker

    self.active = false
    self.dialogue = nil
    self.visibleText = ""

    if self.eventBus then
        self.eventBus:emit("dialogue_ended", {
            speaker = speaker
        })
    end
end

function DialogueUI:is_active()
    return self.active
end

function DialogueUI:update(dt)
    if not self.active then
        return
    end

    local currentLine = self.dialogue.lines[self.currentLine]

    if not currentLine then
        return
    end

    local totalCharacters = utf8.len(currentLine)

    if self.visibleCharacters >= totalCharacters then
        return
    end

    self.characterTimer = self.characterTimer + dt

    local interval = 1 / self.charactersPerSecond

    while self.characterTimer >= interval
        and self.visibleCharacters < totalCharacters do

        self.visibleCharacters = self.visibleCharacters + 1

        self.characterTimer = self.characterTimer - interval
    end

    self.visibleText = utf8_sub(
        currentLine,
        1,
        self.visibleCharacters
    )
end

function DialogueUI:keypressed(key)
    if not self.active then
        return
    end

    if key == "escape" then
        self:close()
        return
    end

    if key ~= "e" and key ~= "return" and key ~= "space" then
        return
    end

    local currentLine = self.dialogue.lines[self.currentLine]
    local totalCharacters = utf8.len(currentLine)

    if self.visibleCharacters < totalCharacters then
        self.visibleCharacters = totalCharacters
        self.visibleText = currentLine
        return
    end

    self.currentLine = self.currentLine + 1
    self.visibleText = ""
    self.visibleCharacters = 0
    self.characterTimer = 0

    if self.currentLine > #self.dialogue.lines then
        self:close()
    end
end

function DialogueUI:render()
    if not self.active then
        return
    end

    local layout = self.layout
    local dialogue = self.dialogue

    love.graphics.setColor(0.04, 0.07, 0.06, 0.94)

    love.graphics.rectangle(
        "fill",
        layout.x,
        layout.y,
        layout.width,
        layout.height,
        12,
        12
    )

    love.graphics.setColor(0.65, 0.78, 0.64)
    love.graphics.setLineWidth(2)

    love.graphics.rectangle(
        "line",
        layout.x,
        layout.y,
        layout.width,
        layout.height,
        12,
        12
    )

    love.graphics.setColor(0.85, 0.92, 0.72)

    love.graphics.print(
        dialogue.name or dialogue.speaker or "Desconocido",
        layout.x + 20,
        layout.y + 12
    )

    love.graphics.setColor(0.7, 0.8, 0.72)

    love.graphics.print(
        dialogue.species or "",
        layout.x + 20,
        layout.y + 35
    )

    love.graphics.setColor(0.65, 0.75, 0.68)

    local details = ""

    if dialogue.description then
        details = dialogue.description
    end

    if dialogue.personality then
        if details ~= "" then
            details = details .. " | "
        end

        details = details .. dialogue.personality
    end

    love.graphics.printf(
        details,
        layout.x + 20,
        layout.y + 57,
        layout.width - 40,
        "left"
    )

    love.graphics.setColor(0.35, 0.48, 0.38)

    love.graphics.line(
        layout.x + 20,
        layout.y + 82,
        layout.x + layout.width - 20,
        layout.y + 82
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        self.visibleText,
        layout.x + 20,
        layout.y + 95,
        layout.width - 40,
        "left"
    )

    love.graphics.setColor(0.8, 0.85, 0.8)

    love.graphics.printf(
        "E / ENTER - Continuar     ESC - Cerrar",
        layout.x,
        layout.y + 155,
        layout.width,
        "center"
    )

    love.graphics.setColor(1, 1, 1)
end

return DialogueUI