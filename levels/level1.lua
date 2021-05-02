local composer = require( "composer" )
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
end



function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/background_image.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 50, 50)
    back_button.x = display.contentCenterX - 120
    back_button.y = display.contentCenterY - 245
    back_button:addEventListener("tap", go_to_level_menu)

    test_table = {}

    for x = 40, 280, 40 do
        for y = 140, 340, 40 do
            test_table[y] = x
        end
    end

    for k, v in pairs(test_table) do
        print(k, v)
    end

    local text_options = {
        text = "Прослушай историю и ответь на вопросы",     
        x = 160,
        y = 150,
        width = 300,
        height = 75,
        font = native.systemFont,   
        fontSize = 26,
        align = "center"  -- Alignment parameter
    }    
    local text = display.newText(text_options)
    text:setFillColor( 1, 0, 0 )
    sceneGroup:insert(text)

    local question1_text_options = {
        text = "1. Что произошло в домике на опушке?",     
        x = 130,
        y = 338,
        width = 300,
        height = 75,
        font = native.systemFont,   
        fontSize = 26,
        align = "center" 
    }
    local question1_text = display.newText(question1_text_options)
    sceneGroup:insert(question1_text)


    local question2_text_options = {
        text = "2. Кто главный герой истории?",     
        x = 169,
        y = 410,
        width = 300,
        height = 75,
        font = native.systemFont,   
        fontSize = 26,
        align = "left" 
    }
    local question2_text = display.newText(question2_text_options)
    sceneGroup:insert(question2_text)


    local question3_text_options = {
        text = "3. Кто пришёл в гости?",     
        x = 150,
        y = 480,
        width = 300,
        height = 75,
        font = native.systemFont,   
        fontSize = 26,
        align = "center" 
    }
    local question3_text = display.newText(question3_text_options)
    sceneGroup:insert(question3_text)

    
 -- local background_music = audio.loadStream('music_placeholder.mp3')
 -- local background_music_channel = audio.play( background_music, { channel=1, loops=-1, fadein=5000 } )

end

function scene:show( event )
    local sceneGroup = self.view   
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:destroy( event )
    local sceneGroup = self.view

    if (phase == "did") then 
        composer.removeScene("level1")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene