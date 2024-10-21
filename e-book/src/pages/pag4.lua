local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 

    navButtons.createNextButton(sceneGroup, "src.pages.pag5")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag3")
end

scene:addEventListener("create", scene)

return scene
