local composer = require("composer")
local scene = composer.newScene()


local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 0, 0, 0.5)

    local modalBox = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY, 633, 200, 15)
    modalBox:setFillColor(0.725, 0.580, 0.439)

    local ref = display.newText({
        parent = sceneGroup,
        text = "Referências",
        x = display.contentCenterX,
        y = display.contentCenterY - 70,
        width = 280,
        font = bacasime,
        fontSize = 24,
        align = "center"
    });

    ref:setFillColor(0,0,0)

    local message = display.newText({
        parent = sceneGroup,
        text = "Catani, A., Bandouk, A. C., Carvalho, E. G., dos Santos, F. S., Vicentini Aguilar, J. B., Salles, J. V., Oliveira, M. M. A., Campos, S. H. A., Nahas, T. R., & Chacon, V. Ser protagonista box: Biologia, ensino médio: volume único. São Paulo: Edições SM, 2014.",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 600,
        font = bacasime,
        fontSize = 20,
    })
    message:setFillColor(0, 0, 0)

    local closeButton = display.newText({
        parent = sceneGroup,
        text = "Fechar",
        x = display.contentCenterX,
        y = display.contentCenterY + 65,
        font = native.systemFontBold,
        fontSize = 18
    })

    local function closeModal()
        composer.hideOverlay("fade", 400)
    end
    closeButton:addEventListener("tap", closeModal)
    local function closeOnBackgroundTap(event)
        if event.target == background then
            composer.hideOverlay("fade", 400)
        end
    end

    background:addEventListener("tap", closeOnBackgroundTap)
end

scene:addEventListener("create", scene)
return scene
