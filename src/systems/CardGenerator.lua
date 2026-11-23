local CardGenerator = {}

local cardPool = {
    {
        name = "Rosa encantadora",
        category = "Romantica",
        description = "Una rosa que transmite elegancia y afecto.",
        value = 3
    },
    {
        name = "Carta de amor",
        category = "Romantica",
        description = "Un mensaje escrito con mucho sentimiento.",
        value = 4
    },
    {
        name = "Conversacion sincera",
        category = "Social",
        description = "Una charla honesta que fortalece los vinculos.",
        value = 2
    },
    {
        name = "Nuevo amigo",
        category = "Social",
        description = "Alguien que podria convertirse en una gran amistad.",
        value = 3
    },
    {
        name = "Paseo bajo el sol",
        category = "Vitalidad",
        description = "Un paseo tranquilo para recuperar el animo.",
        value = 4
    },
    {
        name = "Fruta fresca",
        category = "Vitalidad",
        description = "Un refrigerio que devuelve las energias.",
        value = 2
    }
}

local function get_category_weight(stats, category)
    if category == "Romantica" then
        return 1 + stats.charm * 0.25
    elseif category == "Social" then
        return 1 + stats.confidence * 0.25
    elseif category == "Vitalidad" then
        return 1 + stats.energy * 0.25
    end

    return 1
end

local function choose_card(stats)
    local totalWeight = 0
    local weightedCards = {}

    for _, card in ipairs(cardPool) do
        local weight = get_category_weight(stats, card.category)

        totalWeight = totalWeight + weight

        table.insert(weightedCards, {
            card = card,
            weight = weight
        })
    end

    local randomValue = love.math.random() * totalWeight

    for _, entry in ipairs(weightedCards) do
        randomValue = randomValue - entry.weight

        if randomValue <= 0 then
            return entry.card
        end
    end

    return cardPool[#cardPool]
end

function CardGenerator.generate(gameState, amount)
    local offers = {}

    for i = 1, amount do
        local selectedCard = choose_card(gameState.stats)

        local card = {
            name = selectedCard.name,
            category = selectedCard.category,
            description = selectedCard.description,
            value = selectedCard.value
        }

        table.insert(offers, card)
    end

    return offers
end

return CardGenerator