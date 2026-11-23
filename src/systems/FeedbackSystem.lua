local FeedbackSystem = {}

function FeedbackSystem.initialize(eventBus, gameState)
    eventBus:on("action_performed", function(data)
        gameState.feedback.message = data.message
    end)

    eventBus:on("card_acquired", function(card)
        gameState.feedback.message =
            "Obtuviste: " .. card.name
    end)
end

return FeedbackSystem