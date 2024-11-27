local composer = require("composer")

local physics = require("physics")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")
local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

local retangulos = {
    { cor = {0.4549, 0.6706, 0.8039}, especie = "Panthera onca" },
    { cor = {0.4549, 0.8039, 0.7725}, especie = "Felis silvestris" },
    { cor = {0.662745, 0.701961, 0.533333}, especie = "Rosa gallica" },
    { cor = {0.725, 0.580, 0.439}, especie = "Canis familiaris" },
}

local especies = {}

local duplicatasExistentes = {}

local function criarDuplicata(id, x, y)
    local posX = x or math.random(50, screenWidth - 50)
    local posY = y or math.random(screenHeight * 0.5, screenHeight - 50)

    local duplicata = display.newRoundedRect(posX, posY, 70, 70, 50)
    duplicata:setFillColor(unpack(retangulos[id].cor))
    duplicata.id = id
    duplicata.jaColidiu = false 
    physics.addBody(duplicata, "dynamic", {bounce = 1})
    duplicata:setLinearVelocity(math.random(-50, 50), math.random(-50, 50))
    table.insert(duplicatasExistentes, duplicata) 
    return duplicata
end

local function onCollision(event)
    if event.phase == "began" then
        local obj1 = event.object1
        local obj2 = event.object2

        if obj1.id and obj2.id and obj1.id == obj2.id and not obj1.jaColidiu and not obj2.jaColidiu then
            obj1.jaColidiu = true
            obj2.jaColidiu = true

            local newX = (obj1.x + obj2.x) / 2
            local newY = (obj1.y + obj2.y) / 2

            timer.performWithDelay(10, function()
                criarDuplicata(obj1.id, newX + math.random(-30, 30), newY + math.random(-30, 30))
            end)
        end
    end
end

local function aplicarAtracao()
    for _, duplicata in ipairs(duplicatasExistentes) do
        if duplicata and duplicata.x and duplicata.y and not duplicata.jaColidiu then
            local fixo = especies[duplicata.id]

            local dx = fixo.x - duplicata.x
            local dy = fixo.y - duplicata.y

           local distancia = math.sqrt(dx^2 + dy^2)

           if distancia > 20 then
                local forcaX = (dx / distancia) * 0.2 
                local forcaY = (dy / distancia) * 0.2 

                duplicata:applyForce(forcaX, forcaY, duplicata.x, duplicata.y)
            end
        end
    end
end

local function resetDuplicatas()
    -- Remover todas as duplicatas existentes
    -- for _, duplicata in ipairs(duplicatasExistentes) do
    --     if duplicata and duplicata.removeSelf then
    --         duplicata:removeSelf()
    --     end
    -- end
    duplicatasExistentes = {}

    for i = 1, #retangulos do
        criarDuplicata(i)
    end
end

local function resetListeners()
    -- Remover listeners existentes para evitar duplicação
    Runtime:removeEventListener("collision", onCollision)
    Runtime:removeEventListener("enterFrame", aplicarAtracao)

    -- Adicionar novamente os listeners necessários
    Runtime:addEventListener("collision", onCollision)
    Runtime:addEventListener("enterFrame", aplicarAtracao)
end

local function resetPhysics()
    physics.pause()
    physics.start()
    physics.setGravity(0, 0)
end

local function resetScene()
    resetPhysics()

    resetDuplicatas()

    resetListeners()
end

local function onTouch(event)
    if event.phase == "began" then
        -- Ativar a física
        physics.start()
        physics.setGravity(0, 0)

        -- Criar as duplicatas e inicializar a interação
        resetScene()

        -- Remover o listener de toque após a primeira interação
        Runtime:removeEventListener("touch", onTouch)
        
        -- Runtime:addEventListener("collision", onCollision)
        -- Runtime:addEventListener("enterFrame", aplicarAtracao)
    end
end



function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 
    
    local background = display.newRect(sceneGroup, screenWidth/2, (50 + (screenHeight - 30)) / 2, screenWidth - 60, screenHeight - 60)
    background:setFillColor(0.976, 0.922, 0.780)

    local backgroundGreen = display.newRect(sceneGroup, screenWidth/2 , screenHeight/2 - 250, screenWidth - 60, screenHeight/2 - 100)
    backgroundGreen.y = backgroundGreen.y - (screenHeight / 2 - (screenHeight - 50) / 2)
    backgroundGreen:setFillColor(0.372549, 0.435294, 0.321569) 

    local titulo = display.newText({
        parent = sceneGroup,
        text = "Gênero e Espécie",
        x = screenWidth / 2,
        y = 90,
        font = badScript,
        fontSize = 40
    })
    titulo:setFillColor(0.725, 0.580, 0.439)
    
    local texto1 = display.newText({
        parent = sceneGroup,
        text = "O Gênero é um grupo taxonômico que agrupa espécies que compartilham características muito semelhantes e próximas. Ele é o penúltimo nível de classificação na hierarquia taxonômica e inclui uma ou mais espécies que têm uma origem comum e muitas vezes compartilham aspectos morfológicos e genéticos.",
        x = screenWidth / 2,
        y = 200,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto1:setFillColor(1, 1, 1)

    local texto2 = display.newText({
        parent = sceneGroup,
        text = "A Espécie é o nível mais específico da classificação taxonômica e representa o agrupamento mais pequeno e preciso. Dentro de uma espécie, os organismos compartilham praticamente todas as características genéticas e morfológicas e são capazes de se reproduzir entre si, gerando descendentes férteis.",
        x = screenWidth / 2,
        y = 340,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto2:setFillColor(1, 1, 1)

    local instrucao = display.newText({
        parent = sceneGroup,
        text = "Toque para verificar a colisão de espécies iguais que gera descendentes férteis",
        x = screenWidth / 2,
        y = 500,
        width = screenWidth - 320,
        font = bacasime,
        fontSize = 21,
        align = "center"
    })
    instrucao:setFillColor(0.372549, 0.435294, 0.321569)

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "6",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.4, 0.2, 0)

    physics.start()
    physics.setGravity(0, 0)

    for i = 1, #retangulos do
        local retangulo = display.newRoundedRect(sceneGroup, screenWidth * 0.2 * i, screenHeight * 0.6, 100, 100, 50)
        local esp = display.newText({
            parent = sceneGroup,
            text = retangulos[i].especie,
            x = retangulo.x,
            y = retangulo.y,
            width = 50,
            font = bacasime,
            fontSize = 21,
            align = "center"
        })
        retangulo:setFillColor(unpack(retangulos[i].cor))
        retangulo.id = i 
        physics.addBody(retangulo, "static")
        especies[#especies + 1] = retangulo
    end

    -- Runtime:addEventListener("collision", onCollision)

    -- Runtime:addEventListener("enterFrame", aplicarAtracao)

    navButtons.createNextButton(sceneGroup, "src.pages.contraCapa.contraCapa")
    navButtons.createPrevButton(sceneGroup, "src.pages.pag5.pag5")
    soundImage.createSound(sceneGroup, "src/assets/sounds/pag6.mp3")

end

composer.recycleOnSceneChange = true


function scene:show(event)
    if event.phase == "did" then
        Runtime:addEventListener("touch", onTouch)
        composer.removeScene("src.pages.pag5.pag5", false);
        -- resetScene()         
    end
end

function scene:hide(event)
    if event.phase == "will" then
        physics.pause()
        Runtime:removeEventListener("collision", onCollision)
        Runtime:removeEventListener("enterFrame", aplicarAtracao)
        for _, duplicata in ipairs(duplicatasExistentes) do
            if duplicata then
                duplicata:removeSelf() 
            end
        end
        duplicatasExistentes = {} 
    end
end


scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("create", scene)

return scene
