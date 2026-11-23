local CardRenderer = {}

function CardRenderer.draw_card(card, x, y, width, height, selected)
    if selected then
        love.graphics.setColor(0.85, 0.72, 0.35)
    else
        love.graphics.setColor(0.3, 0.34, 0.40)
    end

    love.graphics.rectangle(
        "fill", x, y, width, height, 8, 8
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        card.name,
        x + 8, y + 7, width - 16, "center"
    )

    love.graphics.printf(
        card.category,
        x + 8, y + 30, width - 16, "center"
    )

    love.graphics.printf(
        "Valor: " .. card.value,
        x + 8, y + 52, width - 16, "center"
    )
end

function CardRenderer.draw_details(card, x, y, width)
    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "Detalles de la carta",
        x, y, width, "center"
    )

    love.graphics.printf(
        "Nombre: " .. card.name,
        x, y + 40, width, "center"
    )

    love.graphics.printf(
        "Categoria: " .. card.category,
        x, y + 75, width, "center"
    )

    love.graphics.printf(
        "Valor: " .. card.value,
        x, y + 110, width, "center"
    )

    love.graphics.printf(
        card.description,
        x + 10, y + 155, width - 20, "center"
    )
end

return CardRenderer