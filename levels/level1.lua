local composer = require( "composer" )
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
end



function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/level_1_pic.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 150
    back_button:addEventListener("tap", go_to_level_menu)


    
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