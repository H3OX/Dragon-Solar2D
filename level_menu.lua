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
    composer.gotoScene("level3")
end

local function switch_to_level4()
    composer.gotoScene("level4")
end

local function switch_to_level5()
    composer.gotoScene("level5")
end


function scene:create( event )
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "images/level_selector_background.png", 320, 565)
    background.x = display.contentCenterX
    background.y = display.contentCenterY


    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 50, 50)
    back_button.x = display.contentCenterX - 120
    back_button.y = display.contentCenterY - 245
    back_button:addEventListener("tap", go_to_menu)

    local level1_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    level1_button.x = display.contentCenterX
    level1_button.y = display.contentCenterY - 175
    level1_button:addEventListener("tap", switch_to_level1)

    local level2_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    level2_button.x = display.contentCenterX
    level2_button.y = display.contentCenterY - 100
    level2_button:addEventListener("tap", switch_to_level2)


    local level3_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    level3_button.x = display.contentCenterX
    level3_button.y = display.contentCenterY - 25
    level3_button:addEventListener("tap", switch_to_level3)


    local level4_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    level4_button.x = display.contentCenterX
    level4_button.y = display.contentCenterY + 50
    level4_button:addEventListener("tap", switch_to_level4)


    local level5_button = display.newImageRect(sceneGroup, "images/play_game.png", 100, 100)
    level5_button.x = display.contentCenterX
    level5_button.y = display.contentCenterY + 125
    level5_button:addEventListener("tap", switch_to_level5)


    -- Аналогично доделать меню для остальных 4х уровней. Заменить пикчи в кнопке каждого на соответствующие.



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