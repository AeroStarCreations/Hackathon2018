local composer = require( "composer" )
local gamesparks = require("gamesparks")
local widget = require("widget")
local location = require("location")
 
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

        local function createMap(lat, long)
            userMap:setCenter(lat, long)
            userMap:addMarker(lat, long)
            -- userMap:setCenter(39.9977, -83.0086)
            -- userMap:addMarker(39.9977, -83.0086)
            userMap.mapType = "standard"
        end

        if (location.isKnown()) then
            local loc = location.get()
            createMap(loc.latitude, loc.longitude)
        else
            local function callback( event )
                createMap(event.latitude, event.longitude)
                Runtime:removeEventListener( "location", callback )
            end
            location.waitForLocation( callback )
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
