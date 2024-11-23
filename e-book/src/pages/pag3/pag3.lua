local composer = require("composer")
local scene = composer.newScene()

local navButtons = require("src.components.navButtons")
local soundImage = require("src.components.soundImage")

local conteudos = {
    {
        titulo = "Animalia",
        texto = "Inclui os animais que são organismos multicelulares e heterotróficos, ou seja, se alimentam de outros seres vivos. Eles têm mobilidade em alguma fase da vida e incluem mamíferos, aves, répteis, peixes e insetos."
    },
    {
        titulo = "Plantae",
        texto = "Agrupa as plantas, organismos multicelulares e autotróficos que realizam fotossíntese para produzir seu próprio alimento. Exemplos incluem árvores, flores e musgos"
    },
    {
        titulo = "Fungi",
        texto = "Composto por fungos, que são heterotróficos e obtêm nutrientes decompondo matéria orgânica. Incluem cogumelos, bolores e leveduras."
    },
    {
        titulo = "Protista",
        texto = "Abrange organismos simples, unicelulares ou multicelulares, que podem ser autotróficos ou heterotróficos. Exemplos incluem algas e protozoários, como a Ameba"
    },
    {
        titulo = "Monera",
        texto = "Inclui as bactérias e arqueas, que são organismos unicelulares e procariontes (sem núcleo definido). Elas vivem em diversos ambientes, desempenhando papéis essenciais no ecossistema."
    }
}

local indiceAtual = 1
local indiceImagem = 1
local imagemAtual 
local tituloText
local conteudoText
local screenWidth = display.contentWidth
local screenHeight = display.contentHeight
local badScript = native.newFont( "BadScript-Regular.ttf")
local bacasime = native.newFont( "BacasimeAntique-Regular.ttf")

local imagens = {
    {
        imagem = "src/pages/pag3/animalia.png",
        titulo = "Animalia"
    },
    {
        imagem = "src/pages/pag3/plantae.png",
        titulo = "Plantae"
    },
    {
        imagem = "src/pages/pag3/fungi.png",
        titulo = "Fungi"
    },
    {
        imagem = "src/pages/pag3/protista.png",
        titulo = "Protista"
    },
    {
        imagem = "src/pages/pag3/monera.png",
        titulo = "Monera"
    }
}

function scene:create(event)
    local sceneGroup = self.view

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1) 

    local backgroundGreen = display.newRect(sceneGroup, screenWidth/2, (50 + (screenHeight - 30)) / 2, screenWidth - 60, screenHeight - 60)
    backgroundGreen:setFillColor(0.662745, 0.701961, 0.533333)

    local background = display.newRect(sceneGroup, screenWidth/2 , screenHeight/2 - 200, screenWidth - 60, screenHeight/2)
    background.y = background.y - (screenHeight / 2 - (screenHeight - 50) / 2)
    background:setFillColor(0.725, 0.580, 0.439)

    local titulo = display.newText({
        parent = sceneGroup,
        text = "Reinos",
        x = screenWidth / 2,
        y = 70,
        font = badScript,
        fontSize = 40
    })
    titulo:setFillColor(0.4, 0.2, 0)
    
    local textoIntro = display.newText({
        parent = sceneGroup,
        text = "Os seres vivos são classificados em cinco grandes reinos: Animalia, Plantae, Fungi, Protista e Monera.",
        x = screenWidth / 2,
        y = 140,
        width = screenWidth - 120,
        font = bacasime,
        fontSize = 21,
        align = "left"
    })
    textoIntro:setFillColor(0, 0, 0)
    
    local caixa = display.newRoundedRect(sceneGroup, screenWidth / 2, screenHeight / 2 - 190, screenWidth - 140, screenHeight / 4, 16)
    caixa:setFillColor(0.4, 0.2, 0)
    
    local tituloInteracao = display.newText({
        parent = sceneGroup,
        text = imagens[indiceImagem].titulo,
        x = screenWidth / 2,
        y = 600,
        font = bacasime,
        fontSize = 40
    })
    tituloInteracao:setFillColor(0, 0, 0)
    -- tituloInteracao.strokeWidth = 8  
    -- tituloInteracao:setStrokeColor(1,0,0)

    local instrucao = display.newText({
        parent = sceneGroup,
        text = "Pince para ver os representantes de cada reino",
        x = screenWidth / 2 - 260,
        y = 660,
        width = 150,
        font = badScript,
        fontSize = 22,
        align = "center"
    })
    instrucao:setFillColor(0, 0, 0)

    local pageNumberText = display.newText({
        parent = sceneGroup,
        text = "3",  
        x = display.contentCenterX,
        y = display.contentHeight - 50,  
        font = bacasime,
        fontSize = 36
    })
    pageNumberText:setFillColor(0.976, 0.922, 0.780)

    navButtons.createNextButton(sceneGroup, "src.pages.pag4")

    navButtons.createPrevButton(sceneGroup, "src.pages.pag2.pag2")

    s = soundImage.createSound(sceneGroup, "src/assets/sounds/pag3.mp3")

    local function atualizarConteudo()
        tituloText.text = conteudos[indiceAtual].titulo
        conteudoText.text = conteudos[indiceAtual].texto
    end

    local function avancar(event)
        if event.phase == "ended" then
            indiceAtual = indiceAtual + 1
            if indiceAtual > #conteudos then
                indiceAtual = 1 
            end
            atualizarConteudo()
        end
    end

    local function voltar(event)
        if event.phase == "ended" then
            indiceAtual = indiceAtual - 1
            if indiceAtual < 1 then
                indiceAtual = #conteudos 
            end
            atualizarConteudo()
        end
    end

    tituloText = display.newText({
        parent = sceneGroup,
        text = conteudos[indiceAtual].titulo,
        x = caixa.x,
        y = caixa.y - 100,
        width = screenWidth - 100,
        font = badScript,
        fontSize = 24,
        align = "center"
    })
    tituloText:setFillColor(0.976, 0.922, 0.780)

    conteudoText = display.newText({
        parent = sceneGroup,
        text = conteudos[indiceAtual].texto,
        x = caixa.x,
        y = caixa.y - 20,
        width = screenWidth - 170,
        font = bacasime,
        fontSize = 21,
        align = "center"
    })
    conteudoText:setFillColor(0.976, 0.922, 0.780)

    local botaoVoltar = display.newImageRect(sceneGroup, "src/assets/left.png", 20, 20)
    botaoVoltar.x = 50
    botaoVoltar.y = caixa.y + 20
    botaoVoltar:addEventListener("touch", voltar)

    local botaoAvancar = display.newImageRect(sceneGroup, "src/assets/right.png", 20, 20)
    botaoAvancar.x = display.contentWidth - 50
    botaoAvancar.y = caixa.y+20
    botaoAvancar:addEventListener("touch", avancar)

    local function avancarImagem(event)
        if imagem then
            imagem:removeSelf()
        end
        
        if event.phase == "ended" then
            indiceImagem = indiceImagem + 1
            if indiceImagem > #imagens then
                indiceImagem = 1 
            end
        end

        tituloInteracao.text = imagens[indiceImagem].titulo 
        imagem = display.newImageRect(sceneGroup, imagens[indiceImagem].imagem, 300, 300)
        imagem.x = display.contentCenterX 
        imagem.y = display.contentCenterY + 280
    end
    
    local imagem = display.newImageRect(sceneGroup, imagens[indiceImagem].imagem, 300, 300)
    imagem.x = display.contentCenterX 
    imagem.y = display.contentCenterY + 280
    imagem:addEventListener("touch", avancarImagem)

   
end

composer.recycleOnSceneChange = true

function scene:destroy()
    -- s:disposeSound()
end

scene:addEventListener("destroy", scene)

scene:addEventListener("create", scene)

return scene
