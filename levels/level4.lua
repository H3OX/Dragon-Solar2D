local composer = require( "composer" )
local math = require("math")
local fingerPaint = require("fingerPaint")
local scene = composer.newScene()

local function go_to_level_menu()
    canvas:erase()
    canvas.isActive = false
    composer.gotoScene('level_menu')
end

local function onTouch(event)
    canvas:erase()
end



function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/level_4_background.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 250
    back_button:addEventListener("tap", go_to_level_menu)

    canvas = fingerPaint.newCanvas()

    canvas.width, canvas.height = 350, 800
    canvas.x = display.contentCenterX
    canvas.y = display.contentCenterY
    canvas:setCanvasColor(0, 0, 0, 0)
    canvas:setStrokeWidth(5) 

    local erase_button = display.newImageRect(sceneGroup, "images/erase_button.png", 150, 40)
    erase_button.x = display.contentCenterX
    erase_button.y = display.contentCenterY + 250
    erase_button:addEventListener("tap", onTouch)

end

function scene:show( event )
    canvas.isActive = true
    local sceneGroup = self.view   
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:destroy( event )
    local sceneGroup = self.view

    if (phase == "did") then 
        composer.removeScene("level4")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene