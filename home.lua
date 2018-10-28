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

local function sendSMSMessages ()
    gamesparks.setStatus(safeVar)
    body = gamesparks.getSMSMessageBody(safeVar)
    gamesparks.getICEContacts(function(response)
        local to = {}
        for kNum,vNam in pairs(response) do 
            to[#to+1] = kNum
            -- option to include name. toName[#toName+1] = vNam
        end
        optionsSMS = {to, body}
        --native.showPopup("sms",optionsSMS)
    end)
end

    

local function handleButtonEvent( event )
    if (event.phase == "ended") then
        print("First Condition")
        if (event.target.id == "safeButton") then
            print("I Am Safe")
            sendSMSMessages(1)

        elseif (event.target.id == "notSafeButton") then
            print("That's Not Safe")
            sendSMSMessages(-1)

        elseif (event.target.id == "ICEButton") then
            print("Opening ICE List")
            composer.gotoScene("ICE")
        elseif (event.target.id == "mapButton") then
            print("Opening map view")
            composer.gotoScene("map")
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

        local buttonW = w * 0.8
        local buttonH = h * 0.1
        local numButtons = 4

        local safeButton = widget.newButton({
            id = "safeButton",
            x = w / 2,
            y = h / (numButtons + 1),
            width = buttonW,
            height = buttonH,
            label = "I'M SAFE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0.28, 0.85, 0.40 }, over={ 0.38, 0.95, 0.50 } },
            labelColor = { default={ 0 }, over={ 0 } },
            --onRelease = btnPressed
        })

        local notSafeButton = widget.newButton({
            id = "notSafeButton",
            x = w / 2,
            y = safeButton.y * 2,
            width = buttonW,
            height = buttonH,
            label = "I'M NOT SAFE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0.96, 0.20, 0.20 }, over={ 1, 0.30, 0.30 } },
            labelColor = { default={ 0 }, over={ 0 } },
            --onRelease = btnPressed
        })

        local ICEButton = widget.newButton({
            id = "ICEButton",
            x = w / 2,
            y = safeButton.y * 3,
            width = buttonW,
            height = buttonH,
            label = "ICE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0.2, 0.55, 1 }, over={ 0.3, 0.65, 1 } },
            labelColor = { default={ 0 }, over={ 0 } },
            --onRelease = btnPressed
        })

        local mapButton = widget.newButton({
            id = "mapButton",
            x = w / 2,
            y = safeButton.y * 4,
            width = buttonW,
            height = buttonH,
            label = "Find Location",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 1, 0.51, 0.21 }, over={ 1, 0.61, 0.31 } },
            labelColor = { default={ 0 }, over={ 0 } },
        })

        sceneGroup:insert( safeButton )
        sceneGroup:insert( notSafeButton )
        sceneGroup:insert( ICEButton )
        sceneGroup:insert( mapButton )
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