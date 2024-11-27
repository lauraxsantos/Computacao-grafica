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

    local instrucao = display.newText({
        parent = sceneGroup,
        text = "Toque para da zoom nas formigas e observar as características da Classe Insecta",
        x = screenWidth / 2,
        y = 500,
        width = screenWidth - 320,
        font = bacasime,
        fontSize = 21,
        align = "center"
    })
    instrucao:setFillColor(0.372549, 0.435294, 0.321569)

    -- local formiga = display.newImageRect(sceneGroup,"src/pages/pag4/image.png", 90,90);
    local formiga = display.newImageRect(sceneGroup,"src/pages/pag4/formigas.png", 200,200);
    formiga.x = display.contentCenterX
    formiga.y = display.contentCenterY + 200
    local newImage

    local zoomLevel = 0
    local maxZoom = 2 
    local blurBackground

    local function resetZoomAndHideNewImage(event)

        local bounds = newImage.contentBounds
        if event.x < bounds.xMin or event.x > bounds.xMax or event.y < bounds.yMin or event.y > bounds.yMax then

            transition.to(formiga, {
                time = 500,
                xScale = 1,
                yScale = 1,
                transition = easing.outQuad
            })
            zoomLevel = 0 

            transition.to(newImage, {
                time = 500,
                alpha = 0, 
                onComplete = function()
                    if newImage then
                        newImage:removeSelf() 
                        newImage = nil 
                    end
                end
            })

            if textGroup then
                transition.to(textGroup, {
                    time = 500,
                    alpha = 0, 
                    onComplete = function()
                        textGroup:removeSelf()
                        textGroup = nil
                    end
                })
            end

            transition.to(blurBackground, {
                time = 500,
                alpha = 0,
                onComplete = function()
                    if blurBackground then
                        blurBackground:removeSelf()
                        blurBackground = nil
                    end
                end
            })

            blurBackground:removeEventListener("tap", resetZoomAndHideNewImage)
        end
    end

    local function showNewImage()

        blurBackground = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
        blurBackground:setFillColor(0, 0, 0, 0.7) 
        blurBackground.alpha = 0 

        transition.to(blurBackground, {
            time = 500,
            alpha = 0.7
        })

        newImage = display.newImageRect("src/pages/pag4/image.png", 300, 200)
        newImage.x = display.contentCenterX
        newImage.y = display.contentCenterY + 130
        newImage.alpha = 0
    
        transition.to(newImage, {
            time = 500,
            alpha = 1 
        })
    
        textGroup = display.newGroup()

        local texts = {
            { text = "Antenas", x = newImage.x, y = newImage.y - 80 },
            { text = "Cabeça", x = newImage.x, y = newImage.y - 30 },
            { text = "Patas", x = newImage.x + 100, y = newImage.y - 30 },
            { text = "Patas", x = newImage.x - 100, y = newImage.y},
            { text = "Toráx", x = newImage.x, y = newImage.y + 10 },
            { text = "Abdomen", x = newImage.x, y = newImage.y + 50 }
        }
    
        for _, textData in ipairs(texts) do
            local text = display.newText({
                text = textData.text,
                x = textData.x,
                y = textData.y,
                font = native.systemFontBold,
                fontSize = 20,
                align = "center"
            })
            text:setFillColor(1, 1, 1) 
            textGroup:insert(text)
        end

        blurBackground:addEventListener("tap", resetZoomAndHideNewImage)
    end

    local function applyZoom()
        if zoomLevel == 0 then
            transition.to(formiga, {
                time = 500,
                xScale = 1.7,
                yScale = 1.7,
                transition = easing.outQuad
            })
        elseif zoomLevel == 1 then
            transition.to(formiga, {
                time = 500,
                xScale = 2.2,
                yScale = 2.2,
                transition = easing.outQuad
            })
        elseif zoomLevel == 2 then
            showNewImage()
        end
        zoomLevel = zoomLevel + 1 
    end
    
    formiga:addEventListener("touch", applyZoom)

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
    soundImage.createSound(sceneGroup, "src/assets/sounds/pag4.mp3")
end

composer.recycleOnSceneChange = true

scene:addEventListener("create", scene)

return scene
