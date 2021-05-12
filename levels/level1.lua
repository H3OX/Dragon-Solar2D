local composer = require( "composer" )
local graphics = require("graphics")
local timer = require("timer")
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
    audio.stop()
end

local clockText = display.newText( "02:45", display.contentCenterX, 80, native.systemFont, 72 )
local secondsLeft = 165

clockText:setFillColor( 0.9, 0.8, 1 )

local function updateTime( event )
 
    -- Decrement the number of seconds
    secondsLeft = secondsLeft - 1
 
    -- Time is tracked in seconds; convert it to minutes and seconds
    local minutes = math.floor( secondsLeft / 60 )
    local seconds = secondsLeft % 60
 
    -- Make it a formatted string
    local timeDisplay = string.format( "%02d:%02d", minutes, seconds )
     
    -- Update the text object
    clockText.text = timeDisplay
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
    sceneGroup:insert(clockText)
 

    local countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
    
    local background_music = audio.loadStream("images/WhatsApp Audio 2021-05-06 at 22.57.37.mp4")
    local background_music_channel = audio.play(background_music, { channel=1, loops=-1, fadein=5000 } )


end

function scene:show( event )
    local sceneGroup = self.view   
    audio.play()
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