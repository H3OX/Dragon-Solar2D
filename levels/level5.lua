local composer = require( "composer" )
local math = require("math")
local fingerPaint = require("fingerPaint")
local scene = composer.newScene()

local function go_to_level_menu()
    canvas:erase()
    canvas.isActive = false
    composer.gotoScene('level_menu')
end

local function change_color_to_green(event)
    canvas:setPaintColor(0, 1, 0)
end

local function change_color_to_red(event)
    canvas:setPaintColor(1, 0, 0)
end


function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/level_5_background.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 250
    back_button:addEventListener("tap", go_to_level_menu)

    local text  = display.newText(sceneGroup, "Обведи фрукты красным, а овощи - зеленым", 30, 30, native.systemFont, 13)
    text.x = display.contentCenterX
    text.y = display.contentCenterY - 229
    text:setFillColor(0, 0, 0)

    canvas = fingerPaint.newCanvas()
    
    canvas.width, canvas.height = 350, 600
    canvas.x = display.contentCenterX
    canvas.y = display.contentCenterY
    canvas:setCanvasColor(0, 0, 0, 0)
    canvas:setStrokeWidth(5) 

    local change_to_red = display.newImageRect(sceneGroup, "images/change_to_red.png", 150, 40)
    change_to_red.x = display.contentCenterX - 80
    change_to_red.y = display.contentCenterY + 250
    change_to_red:addEventListener("tap", change_color_to_red)

    local change_to_green = display.newImageRect(sceneGroup, "images/change_to_green.png", 150, 40)
    change_to_green.x = display.contentCenterX + 80
    change_to_green.y = display.contentCenterY + 250
    change_to_green:addEventListener("tap", change_color_to_green)

    local apricot = display.newImageRect(sceneGroup, "images/apricot.png", 50, 40)
    apricot.x = display.contentCenterX + 90
    apricot.y = display.contentCenterY - 200


    local apple = display.newImageRect(sceneGroup, "images/apple.png", 50, 50)
    apple.x = display.contentCenterX - 40
    apple.y = display.contentCenterY - 190

    local carrot = display.newImageRect(sceneGroup, "images/carrot.png", 50, 50)
    carrot.x = display.contentCenterX - 80
    carrot.y = display.contentCenterY - 20

    local kiwi = display.newImageRect(sceneGroup, "images/kiwi.png", 50, 50)
    kiwi.x = display.contentCenterX - 80
    kiwi.y = display.contentCenterY - 130

    local orange = display.newImageRect(sceneGroup, "images/orange.png", 70, 50)
    orange.x = display.contentCenterX
    orange.y = display.contentCenterY + 30

    local paprika = display.newImageRect(sceneGroup, "images/paprika.png", 50, 50)
    paprika.x = display.contentCenterX + 20
    paprika.y = display.contentCenterY - 90

    local repka = display.newImageRect(sceneGroup, "images/repka.png", 50, 50)
    repka.x = display.contentCenterX + 100
    repka.y = display.contentCenterY

    local salad = display.newImageRect(sceneGroup, "images/salad.png", 50, 50)
    salad.x = display.contentCenterX + 80
    salad.y = display.contentCenterY + 150

    local pineapple = display.newImageRect(sceneGroup, "images/pineapple.png", 50, 90)
    pineapple.x = display.contentCenterX - 80
    pineapple.y = display.contentCenterY + 100

    

    
 -- local background_music = audio.loadStream('music_placeholder.mp3')
 -- local background_music_channel = audio.play( background_music, { channel=1, loops=-1, fadein=5000 } )

end

function scene:show( event )
    local sceneGroup = self.view  
    canvas.isActive = true 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:destroy( event )
    local sceneGroup = self.view

    if (phase == "did") then 
        composer.removeScene("level5")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene