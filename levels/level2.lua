local composer = require( "composer" )
local math = require("math")
 
local scene = composer.newScene()

local function go_to_level_menu()
    composer.gotoScene('level_menu')
end

local function onTouch(event)
    if (event.target.type == 1) then
        counter = counter - 1
        counter_text.text = counter
    end
    event.target:removeSelf()
    
end







function scene:create( event )
    local sceneGroup = self.view
    local phase = event.phase
    local background_image = display.newImageRect(sceneGroup, "images/background_image.png", 320, 575)
    background_image.x = display.contentCenterX
    background_image.y = display.contentCenterY

    local back_button = display.newImageRect(sceneGroup, "images/back_button.png", 50, 50)
    back_button.x = display.contentCenterX - 120
    back_button.y = display.contentCenterY - 245
    back_button:addEventListener("tap", go_to_level_menu)

    local flower_path = "images/flower_pic.png"
    local mushroom_path = "images/mushroom_pic.png"
    local sun_path = "images/sun_pic.png"
    local tree_path = "images/tree_pic.png"

    counter = 0
    local scene_text = display.newText("Собери все цветы", 30, 30, native.systemFont, 26)
    scene_text.x = display.contentCenterX 
    scene_text.y = display.contentCenterY - 200
    scene_text:setFillColor(1, 0, 0)
    sceneGroup:insert(scene_text)


    local row1 = {
        [30 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [70 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [110 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [150 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [190 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [230 + 10] = 40 + 20 + 20 + 20 + 20+ 20,
        [270 + 10] = 40 + 20 + 20 + 20 + 20+ 20
    }
    local row2 = {
        [30 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [70 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [110 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [150 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [190 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [230 + 10] = 80 + 20 + 20 + 20 + 20 + 20,
        [270 + 10] = 80 + 20 + 20 + 20 + 20 + 20
    }
    local row3 = {
        [30 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [70 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [110 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [150 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [190 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [230 + 10] = 120 + 20 + 20 + 20 + 20 + 20,
        [270 + 10] = 120 + 20 + 20 + 20 + 20 + 20
    }
    local row4 = {
        [30 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [70 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [110 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [150 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [190 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [230 + 10] = 160 + 20 + 20 + 20 + 20 + 20,
        [270 + 10] = 160 + 20 + 20 + 20 + 20 + 20
    }

    local row5 = {
        [30 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [70 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [110 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [150 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [190 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [230 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20,
        [270 + 10] = 160 + 40 + 20 + 20 + 20 + 20 + 20
    }

    local row6 = {
        [30 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [70 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [110 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [150 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [190 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [230 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20,
        [270 + 10] = 160 + 40 + 40 + 20 + 20 + 20 + 20 + 20
    }

    for x, y in pairs(row1) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end

    for x, y in pairs(row2) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end

    for x, y in pairs(row3) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end

    for x, y in pairs(row4) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end

    for x, y in pairs(row5) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end

    for x, y in pairs(row6) do
        local objects = {flower_path, mushroom_path, sun_path, tree_path}
        rand_idx = math.random(1, 4)
        if (rand_idx == 1) then
            counter = counter + 1
        end
        
        local image = display.newImageRect(objects[rand_idx], 30, 30)
        image:addEventListener("tap", onTouch)
        image.type = rand_idx
        image.x = x
        image.y = y
        sceneGroup:insert(image)
    end
    misc_text = display.newText('Осталось цветов: ', 30, 30, native.systemFont, 20)
    misc_text.x = display.contentCenterX - 30
    misc_text.y = display.contentCenterY + 200
    misc_text:setFillColor(1, 0, 0)
    sceneGroup:insert(misc_text)


    counter_text = display.newText(counter, 30, 30, native.systemFont, 20)
    counter_text.x = display.contentCenterX + 60
    counter_text.y = display.contentCenterY + 200
    counter_text:setFillColor(1, 0, 0)
    sceneGroup:insert(counter_text)


    

    
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
        composer.removeScene("level2")
    end


end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene