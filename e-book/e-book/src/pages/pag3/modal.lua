local composer = require("composer")
local scene = composer.newScene()


local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 0, 0, 0.5)

    local modalBox = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY, 360, 200, 15)
    modalBox:setFillColor(0.976, 0.922, 0.780)

    local message = display.newText({
        parent = sceneGroup,
        text = "Até o fim do século XIX, havia apenas o reino Vegetal (que englobava plantas e fungos) e o reino animal, proposto por Lineu. O reino Mineral foi abolido anos antes pois não representava os seres vivos.",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = 320,
        height = 170,
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

    closeButton:setFillColor(0, 0, 0)

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
