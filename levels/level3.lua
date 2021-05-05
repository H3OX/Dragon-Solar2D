local composer = require( "composer" )
local math = require("math")
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
end


local function next_page_transition()
    composer.gotoScene('levels.level_3_page_2')
end





function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/level_menu_background.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 250
    back_button:addEventListener("tap", go_to_level_menu)
    
    local choco = display.newImageRect(sceneGroup, "images/choco.png", 70, 70)
    choco.x = display.contentCenterX - 50
    choco.y = display.contentCenterY + 20

    local onion = display.newImageRect(sceneGroup, "images/onion.png", 70, 70)
    onion.x = display.contentCenterX - 20
    onion.y = display.contentCenterY + 150

    local banana = display.newImageRect(sceneGroup, "images/banana.png", 70, 70)
    banana.x = display.contentCenterX - 100
    banana.y = display.contentCenterY + 100

    local watermelon = display.newImageRect(sceneGroup, "images/watermelon.png", 70, 70)
    watermelon.x = display.contentCenterX + 50
    watermelon.y = display.contentCenterY - 30

    local lemon = display.newImageRect(sceneGroup, "images/lemon.png", 70, 70)
    lemon.x = display.contentCenterX + 50
    lemon.y = display.contentCenterY + 150

    local next_page = display.newImageRect(sceneGroup, "images/next_page.png", 70, 70)
    next_page.x = display.contentCenterX + 100
    next_page.y = display.contentCenterY + 220
    next_page:addEventListener("tap", next_page_transition)

    local next_page_text = display.newText(sceneGroup, "Следующая страница", 30, 30, native.systemFont, 15)
    next_page_text.x = display.contentCenterX - 30
    next_page_text.y = display.contentCenterY + 220
    next_page_text:setFillColor(0, 0, 0)
    

    
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
        composer.removeScene("level3")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene