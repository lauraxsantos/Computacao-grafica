local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "src/assets/contra.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    navButtons.createBackButton(sceneGroup, "src.pages.capa")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag6")

    soundImage.createSound(sceneGroup, "src/assets/sounds/contra.mp3")
end

scene:addEventListener("create", scene)

return scene
