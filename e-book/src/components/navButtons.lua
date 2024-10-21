local composer = require("composer")
local navButtons = {}

function navButtons.createNextButton(sceneGroup, nextPage)
    local nextPageButton = display.newImageRect(sceneGroup, "src/assets/proximo.png", 150, 40) 
    nextPageButton.x = 660
    nextPageButton.y = 970
    nextPageButton:addEventListener("tap", function() composer.gotoScene(nextPage) end)
    return nextPageButton
end

function navButtons.createPrevButton(sceneGroup, prevPage)
    local prevPageButton = display.newImageRect(sceneGroup, "src/assets/anterior.png", 125, 40) 
    prevPageButton.x = 100
    prevPageButton.y = 970
    prevPageButton:addEventListener("tap", function() composer.gotoScene(prevPage) end)
    return prevPageButton
end

function navButtons.createBackButton(sceneGroup, prevPage)
    local prevPageButton = display.newImageRect(sceneGroup, "src/assets/inicio.png", 200, 40) 
    prevPageButton.x = 650
    prevPageButton.y = 970
    prevPageButton:addEventListener("tap", function() composer.gotoScene(prevPage) end)
    return prevPageButton
end

return navButtons
