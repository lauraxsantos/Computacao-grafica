local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")

local som
local musicaDeFundo

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "src/assets/capa.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    navButtons.createNextButton(sceneGroup, "src.pages.pag2.pag2")
    s = soundImage.createSound(sceneGroup, "src/assets/sounds/capa.mp3")

end

composer.recycleOnSceneChange = true

function scene:destroy()
    -- s:disposeSound()
end

scene:addEventListener("destroy", scene)
scene:addEventListener("create", scene)

return scene