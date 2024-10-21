local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "src/assets/capa.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    navButtons.createNextButton(sceneGroup, "src.pages.pag2")

end

scene:addEventListener("create", scene)

return scene