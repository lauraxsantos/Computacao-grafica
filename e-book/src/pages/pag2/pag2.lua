local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")
local widget = require("widget")

local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

local categorias = {"Reino", "Filo", "Classe", "Ordem", "Família", "Gênero", "Espécie"}
local posicoes = {}
local conteudo = {
    "Reino", "Filo", "Classe", "Ordem", "Família", "Gênero", "Espécie"
}
local posicoesIniciais = {}

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 

    local backgroundGreen = display.newRect(sceneGroup, screenWidth/2, (50 + (screenHeight - 30)) / 2, screenWidth - 60, screenHeight - 60)
    backgroundGreen:setFillColor(0.372549, 0.435294, 0.321569)

    local background = display.newRect(sceneGroup, screenWidth/2 , screenHeight/2 - 250, screenWidth - 60, screenHeight/2 - 100)
    background.y = background.y - (screenHeight / 2 - (screenHeight - 50) / 2)
    background:setFillColor(0.725, 0.580, 0.439)

    s = soundImage.createSound(sceneGroup, "src/assets/sounds/pag2.mp3")

    local texto1 = display.newText({
        parent = sceneGroup,
        text = "A taxonomia é o ramo da biologia que se dedica a classificar os seres vivos em grupos com base em suas semelhanças e diferenças, organizando-os em categorias taxonômicas.",
        x = screenWidth / 2,
        y = 140,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto1:setFillColor(0, 0, 0)

    local texto2 = display.newText({
        parent = sceneGroup,
        text = "As categorias taxonômicas seguem uma hierarquia que vai do nível mais abrangente até o mais específico. No topo dessa hierarquia está o Reino, que agrupa seres vivos com características muito amplas, como o Reino Animalia, que inclui todos os animais. Abaixo do Reino, encontramos o Filo. A hierarquia continua com as categorias de Classe, Ordem, Família, Gênero e Espécie, que é a unidade mais específica de classificação, composta por organismos que podem cruzar entre si e produzir descendentes férteis.",
        x = screenWidth / 2,
        y = 280,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    texto2:setFillColor(0, 0, 0)

    local instrucao = display.newText({
        parent = sceneGroup,
        text = "Arraste para ordenar e visualizar a hierarquia das categorias taxonômicas",
        x = screenWidth / 2,
        y = 500,
        width = 600,
        font = badScript,
        fontSize = 22,
        align = "center"
    })
    instrucao:setFillColor(1,1,1)

    for i = 1, #categorias do
        local posicao = display.newRoundedRect(sceneGroup, 500, display.contentCenterY + i*60, 100, 50, 10)
        posicao:setFillColor(0.6627, 0.7020, 0.5333) 
        posicao.strokeWidth = 2
        posicao:setStrokeColor(0.8, 0.8, 0.8)
        posicao.nome = categorias[i] 
        posicoes[i] = posicao
    end

    local function dragObject(event)
        local obj = event.target
        if event.phase == "began" then
            display.currentStage:setFocus(obj)
            obj.isDragging = true
            obj.offsetX = event.x - obj.x
            obj.offsetY = event.y - obj.y
        elseif event.phase == "moved" and obj.isDragging then
            obj.x = event.x - obj.offsetX
            obj.y = event.y - obj.offsetY
        elseif event.phase == "ended" or event.phase == "cancelled" then
            display.currentStage:setFocus(nil)
            obj.isDragging = false
            
            for _, posicao in ipairs(posicoes) do
                if math.abs(obj.x - posicao.x) < 50 and math.abs(obj.y - posicao.y) < 25 then
                    obj.x, obj.y = posicao.x, posicao.y 
                    break
                end
            end
        end
        return true
    end

    for i, categoria in ipairs(categorias) do

        local blocoGroup = display.newGroup(sceneGroup)        
        local bloco = display.newRoundedRect(sceneGroup, 300, 500 + i*63, 100, 50, 10)
        bloco:setFillColor(0.662745, 0.701961, 0.533333) 
        blocoGroup:insert(bloco) 
        
        local texto = display.newText(sceneGroup, categoria, bloco.x, bloco.y, badScript, 20)
        texto:setFillColor(0,0,0)
        blocoGroup:insert(texto) 
        sceneGroup:insert(blocoGroup)
        
        blocoGroup:addEventListener("touch", dragObject)
    end


    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "2",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.976, 0.922, 0.780)

    navButtons.createNextButton(sceneGroup, "src.pages.pag3.pag3")

    navButtons.createPrevButton(sceneGroup, "src.pages.capa")
end

composer.recycleOnSceneChange = true

function scene:destroy()
    -- s:disposeSound()
end

scene:addEventListener("destroy", scene)

function scene:show(event)
    if event.phase == "did" then

        imagem.x = posicaoInicialX
        imagem.y = posicaoInicialY
    end
end
scene:addEventListener("create", scene)

return scene
