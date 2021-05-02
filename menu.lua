local composer = require( "composer" )
 
local scene = composer.newScene()

local function switch_to_level_menu()
    composer.gotoScene("level_menu")
end


function scene:create( event )
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "images/menu_background.png", 320, 575)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local play_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    play_button.x = display.contentCenterX + 80
    play_button.y = display.contentCenterY + 150
    play_button:addEventListener("tap", switch_to_level_menu)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:destroy( event )
    local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene