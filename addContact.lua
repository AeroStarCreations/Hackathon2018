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
local contactName
local contactNumber

local function handleButtonEvent( event )
    print("Its working dog")
    if (event.phase == "ended") then
        if (event.target.id == "addButton") then
            if (contactName.text == nil or contactName.text == "" or
            contactNumber.text == nil or contactNumber.text == "") then
                print( "Must fill all fields" )
                --infoClear()
                --infoUpdate( "Must fill all fields" )
            else 
                gamesparks.addICEContact(
                    contactName.text,
                    contactNumber.text
                )
                composer.gotoScene("ICE")
            end
            native.setKeyboardFocus( nil )
        print(event.target.id .. " button pressed")
        end
    elseif (event.phase == "began") then
        event.target:setFillColor(0,1,0)
    end
end

local function inputListener( event )
    
    if ("contactName" == event.target.id) then
        --infoUpdate("contactName")
        if ("submitted" == event.phase or "ended" == event.phase) then
            native.setKeyboardFocus( contactNumber )
        end
    elseif ("contactNumber" == event.target.id) then
        --infoUpdate("password")
        if ("submitted" == event.phase or "ended" == event.phase) then
            native.setKeyboardFocus( nil )
        end
    end
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
        contactName = native.newTextField(w/2, h * .1, w/1.4, h/20)
        contactName.placeholder = "(Contact Name)"
        contactName.id = "contactName"
        contactName:addEventListener( "userInput", inputListener )

        contactNumber = native.newTextField(w/2, h * .2, w/1.4, h/20)
        contactNumber.inputType = "number"
        contactNumber.placeholder = "(Contact Phone)"
        contactNumber.id = "contactNumber"
        contactNumber:addEventListener( "userInput", inputListener )

        local addButton = widget.newButton({
            id = "addButton",
            x = w / 2,
            y = h * .4,
            width = w/1.4,
            height = 2 * contactName.height,
            label = "Add ICE",
            fontSize = contactName.height,
            shape = "roundedRect",
            cornerRadius = contactName.height * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0,191,255 }, over={ 0,191,255 } },
        })

        sceneGroup:insert( contactName )
        sceneGroup:insert( contactNumber )
        sceneGroup:insert( addButton )
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        contactName:removeSelf()
        contactNumber:removeSelf()
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