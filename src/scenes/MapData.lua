local MapData = {}

MapData.width = 800
MapData.height = 600

MapData.background = {
    color = {0.24, 0.48, 0.25}
}

MapData.paths = {
    {
        x = 300,
        y = 250,
        width = 200,
        height = 100
    },
    {
        x = 350,
        y = 100,
        width = 100,
        height = 400
    },
    {
        x = 100,
        y = 280,
        width = 600,
        height = 70
    }
}

MapData.obstacles = {
    -- Árboles
    {x = 80, y = 80, radius = 28},
    {x = 180, y = 100, radius = 25},
    {x = 650, y = 100, radius = 30},
    {x = 730, y = 180, radius = 25},
    {x = 100, y = 500, radius = 30},
    {x = 700, y = 500, radius = 28},

    -- Rocas
    {x = 250, y = 450, radius = 16},
    {x = 570, y = 430, radius = 18}
}

MapData.solidAreas = {
    {
        name = "Estanque",
        x = 320,
        y = 50,
        width = 160,
        height = 90
    }
}

MapData.pointsOfInterest = {
    {
        id = "flower_garden",
        name = "Jardin de flores",
        x = 100,
        y = 270,
        width = 120,
        height = 90,
        color = {1, 0.55, 0.75},
        interactionLabel = "Minijuego de Snake (proximamente)"
    },
    {
        id = "pond",
        name = "Estanque",
        x = 320,
        y = 50,
        width = 160,
        height = 90,
        color = {0.2, 0.55, 0.95},
        dialogueId = "water_snake",
        interactionLabel = "E - Hablar con una serpiente marina"
    },
    {
        id = "forest_clearing",
        name = "Claro del bosque",
        x = 550,
        y = 250,
        width = 160,
        height = 110,
        color = {0.85, 0.75, 0.45},
        dialogueId = "forest_snake",
        interactionLabel = "E - Hablar con una serpiente terrestre"
    }
}

return MapData