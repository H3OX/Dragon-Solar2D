local composer = require( "composer" )
 
local scene = composer.newScene()



function scene:create( event )
    local sceneGroup = self.view

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    local text = display.newText(sceneGroup, "Здесь пока нихуя", 100, 50)
    
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

end

function scene:destroy( event )
    local sceneGroup = self.view

    if (phase == "did") then 
        composer.removeScene("menu")
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene