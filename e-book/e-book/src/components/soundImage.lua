local composer = require("composer");

local soundImage = {}
local msc

function soundImage.createSound(sceneGroup, faixa)
    local sons = {
        "src/assets/som.png",    
        "src/assets/somOff.png" 
    }
    local label = {
        "Som on", 
        "Som off",    
    }

    local indiceAtual = 1  
    local som  
    local instrucao

    local function alternarSom(event)
        indiceAtual = (indiceAtual % 2) + 1

        som:removeSelf() 
        som = display.newImageRect(sceneGroup, sons[indiceAtual], 27, 27)
        som.x = display.contentWidth - 90
        som.y = display.contentHeight/2 - 460
        som:addEventListener("tap", alternarSom) 

        instrucao:removeSelf()
        instrucao = display.newText({
            parent = sceneGroup,
            text = label[indiceAtual],
            x = display.contentWidth - 90,
            y = display.contentHeight/2 - 430,
            width = 600,
            font = native.systemFont,
            fontSize = 22,
            align = "center"
        })
        instrucao:setFillColor(0, 0, 0)

        if indiceAtual == 2 then
            audio.pause()
        else
            audio.resume();
        end
    end

    if faixa then 
        if msc then
            audio.stop();
            audio.dispose(msc)
        end
        msc = audio.loadStream(faixa)
        audio.play(msc, {loops = -1})
        audio.setVolume(0.5)
    else
        audio.stop();
        audio.dispose(msc)
    end

    instrucao = display.newText({
        parent = sceneGroup,
        text = label[indiceAtual],
        x = display.contentWidth - 90,
        y = display.contentHeight/2 - 430,
        width = 600,
        font = native.systemFont,
        fontSize = 22,
        align = "center"
    })
    instrucao:setFillColor(0, 0, 0)

    som = display.newImageRect(sceneGroup, sons[indiceAtual], 27, 27)
    som.x = display.contentWidth - 90
    som.y = display.contentHeight/2 - 460
    som:addEventListener("tap", alternarSom)
    return som
end


return soundImage

