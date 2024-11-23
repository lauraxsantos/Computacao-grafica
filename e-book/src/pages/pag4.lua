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
    backgroundGreen:setFillColor(0.662745, 0.701961, 0.533333) 

    local titulo = display.newText({
        parent = sceneGroup,
        text = "Filo e Classe",
        x = screenWidth / 2,
        y = 90,
        font = badScript,
        fontSize = 40
    })
    titulo:setFillColor(0.4, 0.2, 0)

    
    local texto1 = display.newText({
        parent = sceneGroup,
        text = "O Filo agrupa organismos que compartilham características estruturais e funcionais semelhantes em um nível mais geral. Já a Classe organiza organismos que têm mais características em comum entre si do que com outros organismos do mesmo filo, mas ainda não tão específicos quanto as ordens, famílias ou gêneros.",
        x = screenWidth / 2,
        y = 200,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto1:setFillColor(0, 0, 0)

    local texto2 = display.newText({
        parent = sceneGroup,
        text = "Dentro do Filo Arthropoda, por exemplo, encontramos a Classe Insecta, que inclui os insetos, caracterizados por ter três pares de patas, corpo dividido em cabeça, tórax e abdômen, além de um par de antenas. Outra classe dentro desse filo é a Classe Arachnida, que agrupa aranhas, escorpiões e carrapatos, todos com quatro pares de patas e corpo dividido em cefalotórax e abdômen.",
        x = screenWidth / 2,
        y = 340,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto2:setFillColor(0, 0, 0)

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "4",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.4, 0.2, 0)

    navButtons.createNextButton(sceneGroup, "src.pages.pag5.pag5")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag3.pag3")
    soundImage.createSound(sceneGroup)
end

scene:addEventListener("create", scene)

return scene
