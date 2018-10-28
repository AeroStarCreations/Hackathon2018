--File to create the scene for the login screen
local composer = require( "composer" )
local widget = require( "widget" )
local localData = require("localData")
local gamesparks = require("gamesparks")
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
local w = display.actualContentWidth
local h = display.actualContentHeight
local username
local password
local displayName


local function handleButtonEvent( event )
    if (event.phase == "ended") then
        print("First Condition")
        if (event.target.id == "safeButton") then
            print("I Am Safe")
            gamesparks.setStatus(1)
            optionsSMS = gamesparks.getSMSMessage(1)
            native.showPopup("sms", optionsSMS)
            
        elseif (event.target.id == "notSafeButton") then
            print("That's Not Safe")
            gamesparks.setStatus(-1)
            optionsSMS = gamesparks.getSMSMessage(-1)
            native.showPopup("sms", optionsSMS)
        elseif (event.target.id == "ICEButton") then
            print("Opening ICE List")
            composer.gotoScene("ICE")
        end
        print(event.target.id .. " button pressed")
    elseif (event.phase == "began") then
        event.target:setFillColor(0,0,1)
        print("begin")
    end
end

local function inputListener( event )
    
   
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

        local safeButton = widget.newButton({
            id = "safeButton",
            x = w / 2,
            y = h * .1,
            width = w/1.4,
            height = 2 * (h/20),
            label = "I'M SAFE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0, 200, 0 }, over={ 0, 200, 0 } },
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            --onRelease = btnPressed
        })

        local notSafeButton = widget.newButton({
            id = "notSafeButton",
            x = w / 2,
            y = h * .25,
            width = w/1.4,
            height = 2 * (h/20),
            label = "I'M NOT SAFE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 200, 0, 0 }, over={ 200, 0, 0 } },
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            --onRelease = btnPressed
        })

        local ICEButton = widget.newButton({
            id = "ICEButton",
            x = w / 2,
            y = h * .6,
            width = w/1.4,
            height = 2 * (h/10),
            label = "ICE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 100, 100, 100 }, over={ 100, 100, 100 } },
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            --onRelease = btnPressed
        })

        sceneGroup:insert( safeButton )
        sceneGroup:insert( notSafeButton )
        sceneGroup:insert( ICEButton )
        --safeButton.labelColor = { default={ 0, 200, 0 }, over={ 0, 0, 0, 0.5 } }
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