local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")
local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

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

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "6",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.4, 0.2, 0)

    navButtons.createNextButton(sceneGroup, "src.pages.contraCapa")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag5.pag5")

    soundImage.createSound(sceneGroup, "")
end

function scene:show(event)
    if event.phase == "did" then
        print("oi")
        composer.removeScene("src.pages.pag5.pag5",false);
    end

end

scene:addEventListener("create", scene)

return scene
