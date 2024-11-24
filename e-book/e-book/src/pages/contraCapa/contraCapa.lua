local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "src/assets/contra.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local function abrirModal()
        composer.showOverlay("src.pages.contraCapa.modal", {
            isModal = true, 
            effect = "fade",
            time = 400
        })
    end

    local openButton = display.newImageRect(sceneGroup,"src/assets/info.png",  35, 35);
    openButton.x = display.contentWidth - 710
    openButton.y = display.contentHeight/2 - 460
    
    openButton:addEventListener("tap", abrirModal)

    navButtons.createBackButton(sceneGroup, "src.pages.capa")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag6")

    soundImage.createSound(sceneGroup, "src/assets/sounds/contra.mp3")
end

scene:addEventListener("create", scene)

return scene
