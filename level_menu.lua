local composer = require( "composer" )
local widget = require("widget")
 
local scene = composer.newScene()

local function go_to_menu()
    composer.gotoScene("menu")
end

local function switch_to_level1()
    composer.gotoScene("levels.level1")
end

local function switch_to_level2()
    composer.gotoScene("levels.level2")
end

local function switch_to_level3()
    composer.gotoScene("levels.level3")
end

local function switch_to_level4()
    composer.gotoScene("levels.level4")
end

local function switch_to_level5()
    composer.gotoScene("levels.level5")
end

local function switch_to_level6()
    composer.gotoScene("level6")
end
local function switch_to_level7()
    composer.gotoScene("level7")
end


function scene:create( event )
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "images/level_menu_background.png", 320, 565)
    background.x = display.contentCenterX
    background.y = display.contentCenterY


    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 30, 30)
    back_button.x = display.contentCenterX - 130
    back_button.y = display.contentCenterY - 250
    back_button:addEventListener("tap", go_to_menu)

    local level1_button = display.newImageRect(sceneGroup, "images/level_1.png", 200, 100)
    level1_button.x = display.contentCenterX
    level1_button.y = display.contentCenterY - 200
    level1_button:addEventListener("tap", switch_to_level1)

    local level2_button = display.newImageRect(sceneGroup, "images/level_2.png", 200, 100)
    level2_button.x = display.contentCenterX
    level2_button.y = display.contentCenterY - 135
    level2_button:addEventListener("tap", switch_to_level2)


    local level3_button = display.newImageRect(sceneGroup, "images/level_3.png", 200, 100)
    level3_button.x = display.contentCenterX
    level3_button.y = display.contentCenterY - (135-65)
    level3_button:addEventListener("tap", switch_to_level3)


    local level4_button = display.newImageRect(sceneGroup, "images/level_4.png", 200, 100)
    level4_button.x = display.contentCenterX
    level4_button.y = display.contentCenterY - (135-65-65)
    level4_button:addEventListener("tap", switch_to_level4)


    local level5_button = display.newImageRect(sceneGroup, "images/level_5.png", 200, 100)
    level5_button.x = display.contentCenterX
    level5_button.y = display.contentCenterY - (135-65-65-65)
    level5_button:addEventListener("tap", switch_to_level5)

    local level6_button = display.newImageRect(sceneGroup, "images/level_6.png", 200, 100)
    level6_button.x = display.contentCenterX
    level6_button.y = display.contentCenterY - (135-65-65-65-65)
    level6_button:addEventListener("tap", switch_to_level6)

    local level7_button = display.newImageRect(sceneGroup, "images/level_7.png", 200, 100)
    level7_button.x = display.contentCenterX
    level7_button.y = display.contentCenterY - (135-65-65-65-65-65)
    level7_button:addEventListener("tap", switch_to_level7)
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