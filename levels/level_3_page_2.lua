local composer = require( "composer" )
local math = require("math")
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
end



local function circle_fruit(event)
    if(event.target.class == "choco") then
        event.target:removeSelf()
        choco = display.newImageRect(sceneGroup, "images/choco_circled.png", 70, 70)
        choco.x = display.contentCenterX - 115
        choco.y = display.contentCenterY - 7
    end

    if(event.target.class == "onion") then
        event.target:removeSelf()
        local onion = display.newImageRect(sceneGroup, "images/onion_circled.png", 50, 50)
        onion.x = display.contentCenterX - 5
        onion.y = display.contentCenterY - 135
    end

    if(event.target.class == "banana") then
        event.target:removeSelf()
        local banana = display.newImageRect(sceneGroup, "images/banana_circled.png", 80, 80)
        banana.x = display.contentCenterX - 115
        banana.y = display.contentCenterY - 128
    end

    if(event.target.class == "watermelon") then
        event.target:removeSelf()
        local watermelon = display.newImageRect(sceneGroup, "images/watermelon_circled.png", 100, 100)
        watermelon.x = display.contentCenterX - 21
        watermelon.y = display.contentCenterY + 101
    end

    if(event.target.class == "lemon") then
        event.target:removeSelf()
        local lemon = display.newImageRect(sceneGroup, "images/lemon_circled.png", 75, 65)
        lemon.x = display.contentCenterX + 115
        lemon.y = display.contentCenterY - 115
    end
end




function scene:create( event )
    sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/fridge.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 250
    back_button:addEventListener("tap", go_to_level_menu)
    
    local choco = display.newImageRect(sceneGroup, "images/choco.png", 70, 70)
    choco.x = display.contentCenterX - 115
    choco.y = display.contentCenterY - 7
    choco.class = "choco"
    choco:addEventListener("tap", circle_fruit)


    local onion = display.newImageRect(sceneGroup, "images/onion.png", 50, 50)
    onion.x = display.contentCenterX - 5
    onion.y = display.contentCenterY - 135
    onion.class = "onion"
    onion:addEventListener("tap", circle_fruit)

    local banana = display.newImageRect(sceneGroup, "images/banana.png", 80, 80)
    banana.x = display.contentCenterX - 115
    banana.y = display.contentCenterY - 128
    banana.class = "banana"
    banana:addEventListener("tap", circle_fruit)

    local watermelon = display.newImageRect(sceneGroup, "images/watermelon.png", 100, 100)
    watermelon.x = display.contentCenterX - 21
    watermelon.y = display.contentCenterY + 101
    watermelon.class = "watermelon"
    watermelon:addEventListener("tap", circle_fruit)

    local lemon = display.newImageRect(sceneGroup, "images/lemon.png", 75, 65)
    lemon.x = display.contentCenterX + 115
    lemon.y = display.contentCenterY - 115
    lemon.class = "lemon"
    lemon:addEventListener("tap", circle_fruit)

    
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
        composer.removeScene("level_3_page_2")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene