local composer = require( "composer" )
local gamesparks = require("gamesparks")
local widget = require("widget")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local clock 
local userMap

local function handleButtonEvent( event )
    composer.gotoScene("home")
end
  
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        local buttonHeight = display.actualContentHeight*0.1
        local mapHeight = display.actualContentHeight - buttonHeight

        userMap = native.newMapView(
            display.contentCenterX,
            display.screenOriginY + mapHeight * 0.5,
            display.actualContentWidth,
            mapHeight
        )

        local function locationHandler(event)
            local player = gamesparks.getPlayer()
            print("player="..tostring(player))
            if (player) then
                timer.cancel(clock)
                local currentLocation = player.location
                local locationText = "Current location: " .. currentLocation.latitide .. "," .. currentLocation.longditute
                print("location: "..locationText)
                userMap:setCenter(currentLocation.latitide, currentLocation.longditute)
                userMap:addMarker(currentLocation.latitide, currentLocation.longditute)
                -- userMap:setCenter(39.9977, -83.0086)
                -- userMap:addMarker(39.9977, -83.0086)
                userMap.mapType = "standard"
            end
        end

        local backButton = widget.newButton({
            id = "back",
            x = display.contentCenterX,
            y = display.actualContentHeight - buttonHeight * 0.5,
            width = display.actualContentWidth,
            height = buttonHeight,
            label = "Back",
            fontSize = display.actualContentHeight/20,
            shape = "rect",
            fillColor = { default={ 0.6, 1, 0.6 }, over={ 0.5, 1, 0.5 } },
            labelColor = { default={ 0 }, over={ 0 } },
            onRelease = handleButtonEvent,
        })
        sceneGroup:insert(backButton)
        
        clock = timer.performWithDelay(500, locationHandler, -1)

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        userMap:removeSelf()
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
