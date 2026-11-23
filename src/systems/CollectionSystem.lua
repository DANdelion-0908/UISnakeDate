local CollectionSystem = {}

function CollectionSystem.add_card(gameState, card)
    local newCard = {
        id = gameState.nextCardId,
        name = card.name,
        category = card.category,
        description = card.description,
        value = card.value
    }

    table.insert(gameState.collection, newCard)

    gameState.nextCardId = gameState.nextCardId + 1

    return newCard
end

return CollectionSystem