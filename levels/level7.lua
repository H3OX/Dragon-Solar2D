local composer = require( "composer" )
local math = require("math")
local fingerPaint = require("fingerPaint")
local scene = composer.newScene()

local function go_to_level_menu()
    canvas:erase()
    canvas.isActive = false
    composer.gotoScene('level_menu')
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

    canvas = fingerPaint.newCanvas()
    canvas.isActive = true
    canvas.width, canvas.height = 60, 300
    canvas.x = display.contentCenterX + 100
    canvas.y = display.contentCenterY + 50
    canvas:setCanvasColor(1, 1, 0, 0)
    canvas:setStrokeWidth(5) 

    local text  = display.newText(sceneGroup, "1. Вспомни и расскажи:", 30, 30, native.systemFont, 10)
    text.x = display.contentCenterX - 100
    text.y = display.contentCenterY - 220
    text:setFillColor(0, 0, 0)

    local text2  = display.newText(sceneGroup, "что произошло сегодня на волшебной планете?", 30, 30, native.systemFont, 10)
    text2.x = display.contentCenterX - 33
    text2.y = display.contentCenterY - 210
    text2:setFillColor(0, 0, 0)

    local text3  = display.newText(sceneGroup, "2. Скажи, что в рассказе самое главное.", 30, 30, native.systemFont, 10)
    text3.x = display.contentCenterX - 61
    text3.y = display.contentCenterY - 190
    text3:setFillColor(0, 0, 0)

    local text4  = display.newText(sceneGroup, "Закрась квадратик.", 30, 30, native.systemFont, 10)
    text4.x = display.contentCenterX - 97
    text4.y = display.contentCenterY - 180
    text4:setFillColor(0, 0, 0)

    local text5  = display.newText(sceneGroup, "В этот день раскрыли свои бутоны серебряные колокольчики.", 30, 30, native.systemFont, 10)
    text5.x = display.contentCenterX - 6
    text5.y = display.contentCenterY - 140
    text5:setFillColor(0, 0, 0)

    local pic1 = display.newImageRect(sceneGroup, "images/first_pic.png", 200, 150)
    pic1.x = display.contentCenterX - 50
    pic1.y = display.contentCenterY - 50


    local text6  = display.newText(sceneGroup, "В семье драконов родился необыкновенный ребёнок.", 30, 30, native.systemFont, 10)
    text6.x = display.contentCenterX - 27
    text6.y = display.contentCenterY + 65 
    text6:setFillColor(0, 0, 0)

    local pic2 = display.newImageRect(sceneGroup, "images/third_pic.png", 200, 200)
    pic2.x = display.contentCenterX - 50
    pic2.y = display.contentCenterY + 175

    local checkbox1 = display.newImageRect(sceneGroup, "images/checkbox.png", 50, 50)
    checkbox1.x = display.contentCenterX + 100
    checkbox1.y = display.contentCenterY - 50

    local checkbox2 = display.newImageRect(sceneGroup, "images/checkbox.png", 50, 50)
    checkbox2.x = display.contentCenterX + 100
    checkbox2.y = display.contentCenterY + 150
    

    

    
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
        composer.removeScene("level5")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene