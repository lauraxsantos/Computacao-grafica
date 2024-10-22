local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "2",  
        x = display.contentCenterX,
        y = display.contentHeight - 30,  
        font = native.systemFontBold,
        fontSize = 24
    })
    pageNumberText:setFillColor(0)

    navButtons.createNextButton(sceneGroup, "src.pages.pag3")

    navButtons.createPrevButton(sceneGroup, "src.pages.capa")
end

scene:addEventListener("create", scene)

return scene
