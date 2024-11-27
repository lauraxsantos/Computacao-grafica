local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")
local active = true;

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 
   
    local background = display.newRect(sceneGroup, screenWidth/2, (50 + (screenHeight - 30)) / 2, screenWidth - 60, screenHeight - 60)
    background:setFillColor(0.725, 0.580, 0.439)

    local background2 = display.newRect(sceneGroup, screenWidth/2 , screenHeight/2 - 250, screenWidth - 60, screenHeight/2 - 100)
    background2.y = background2.y - (screenHeight / 2 - (screenHeight - 50) / 2)
    background2:setFillColor(0.4, 0.2, 0) 
    
    local titulo = display.newText({
        parent = sceneGroup,
        text = "Ordem e Família",
        x = screenWidth / 2,
        y = 90,
        font = badScript,
        fontSize = 40
    })
    titulo:setFillColor(0.725, 0.580, 0.439)
    
    local texto1 = display.newText({
        parent = sceneGroup,
        text = "A Ordem é um nível taxonômico que organiza as famílias dentro de uma classe. As ordens agrupam organismos que compartilham características morfológicas ou comportamentais importantes, mas que ainda são mais diversas do que as famílias dentro delas.",
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
        text = "A Família é um nível de classificação mais específico do que a ordem. Ela organiza os organismos dentro de uma ordem em grupos menores e mais relacionados. Os organismos dentro de uma mesma família compartilham características ainda mais específicas, como formas corporais, estrutura de reprodução e padrões de crescimento.",
        x = screenWidth / 2,
        y = 340,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto2:setFillColor(1, 1, 1)

    system.setAccelerometerInterval(60)

    local ordens = {"Carnivora", "Primates"}
    local familias = {"Canidae", "Hominidae"}

    local areas = {}
    for i, label in ipairs(ordens) do
        local area = display.newRoundedRect(sceneGroup, display.contentWidth * 0.35 * i, display.contentHeight * 0.8, 250, 250, 90)
        area:setFillColor(0.8, 0.8, 0.8, 0.5)
        area.label = label
        a = display.newText(sceneGroup, "Ordem " ..label, area.x, area.y - 160, bacasime, 16)
        b = display.newText(sceneGroup, "Família " ..familias[i], area.x, area.y - 140, bacasime, 16)
        a:setFillColor(0,0,0)
        b:setFillColor(0,0,0)
        areas[#areas + 1] = area
    end

    local elementos = {}
    local function criarElemento(imagem, texto, x, y)
        local elemento = display.newImageRect(sceneGroup, imagem, 60, 60)
        elemento.x, elemento.y = x, y
        elemento.label = texto
        elemento.moving = true 
        elementos[#elementos + 1] = elemento
    end

    criarElemento("src/pages/pag5/lobo.png", "Lobo", display.contentWidth * 0.35, display.contentHeight * 0.45)
    criarElemento("src/pages/pag5/cachorro.png", "Cachorro", display.contentWidth * 0.45, display.contentHeight * 0.45)
    criarElemento("src/pages/pag5/gorila.png", "Gorila", display.contentWidth * 0.55, display.contentHeight * 0.45)
    criarElemento("src/pages/pag5/orangotango.png", "Orangotango", display.contentWidth * 0.65, display.contentHeight * 0.45)

    if active then
        local function onAccelerometer(event)
            for _, elemento in ipairs(elementos) do
                if elemento.moving then
                    elemento.x = elemento.x + event.xGravity * 15
                    elemento.y = elemento.y - event.yGravity * 15
                end
            end
        end

        local function verificarLimites()
            for _, elemento in ipairs(elementos) do
                if elemento.x < 0 then
                    elemento.x = display.contentWidth
                elseif elemento.x > display.contentWidth then
                    elemento.x = 0
                end
        
                if elemento.y < 0 then
                    elemento.y = display.contentHeight
                elseif elemento.y > display.contentHeight then
                    elemento.y = 0
                end
            end
        end
        
        
        local function verificarColisoes()
            for _, elemento in ipairs(elementos) do
                for _, area in ipairs(areas) do
                    if math.abs(elemento.x - area.x) < 75 and math.abs(elemento.y - area.y) < 75 then
                        if elemento.label == "Cachorro" and area.label == "Carnivora" or elemento.label == "Lobo" and area.label == "Carnivora" then
                            elemento.moving = false -- Fixa o elemento
                            elemento.x, elemento.y = area.x, area.y -- Centraliza na área
                        elseif elemento.label == "Gorila" and area.label == "Primates" or elemento.label == "Orangotango" and area.label == "Primates" then
                            elemento.moving = false -- Fixa o elemento
                            elemento.x, elemento.y = area.x, area.y -- Centraliza na área
                        end
                    end
                end
            end
        end
        if composer.getSceneName("current") == "src.pages.pag5.pag5" then
            Runtime:addEventListener("accelerometer", onAccelerometer)
            Runtime:addEventListener("enterFrame", verificarLimites)
            Runtime:addEventListener("enterFrame", verificarColisoes)
        -- else
        --     Runtime:removeEventListener("accelerometer", onAccelerometer)
        --     Runtime:removeEventListener("enterFrame", verificarLimites)
        --     Runtime:removeEventListener("enterFrame", verificarColisoes)
        end
    end

    local instrucion = display.newText({
        parent = sceneGroup,
        text= "Mova o dispositivo para um lado e para o outro para visualizar representantes da mesma ordem e família",
        x = display.contentCenterX,
        y = display.contentCenterY + 50,  
        width = 700,
        font = badScript,
        fontSize = 24,
        align = 'center'
    });

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "5",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.372549, 0.435294, 0.321569)
    navButtons.createNextButton(sceneGroup, "src.pages.pag6")
    
    navButtons.createPrevButton(sceneGroup, "src.pages.pag4.pag4")
    soundImage.createSound(sceneGroup, "src/assets/sounds/pag5.mp3")

    if composer.getSceneName("current") == "src.pages.pag5.pag5" then
        composer.removeScene("src.pages.pag5.pag5")
    end

end

composer.recycleOnSceneChange = true

function scene:destroy()
    Runtime:removeEventListener("accelerometer", onAccelerometer)
    Runtime:removeEventListener("enterFrame", verificarLimites)
    Runtime:removeEventListener("enterFrame", verificarColisoes)
end

scene:addEventListener("destroy", scene)
scene:addEventListener("create", scene)

return scene
