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
        if (event.target.id == "login") then
            if (username.text == nil or username.text == "" or
            password.text == nil or password.text == "") then
                print( "Must fill all fields" )
                --infoClear()
                --infoUpdate( "Must fill all fields" )
            else 
                gamesparks.registerWithUsernameAndPassword(
                    displayName.text,
                    username.text, 
                    password.text
                )
                localData.setPassword(password.text)
                localData.setUsername(username.text)
                localData.setRegistered(true)
                composer.gotoScene("home")
            end
            native.setKeyboardFocus( nil )
        elseif (event.target.id == "back") then
            composer.gotoScene( composer.getSceneName( "previous" ))
        end
        print(event.target.id .. " button pressed")
    elseif (event.phase == "began") then
        event.target:setFillColor(0,1,0)
    end
end

local function inputListener( event )
    
    if ("username" == event.target.id) then
        --infoUpdate("username")
        if ("submitted" == event.phase or "ended" == event.phase) then
            --infoUpdate("username submitted")
            native.setKeyboardFocus( password )
        end
    elseif ("password" == event.target.id) then
        --infoUpdate("password")
        if ("submitted" == event.phase or "ended" == event.phase) then
            --infoUpdate("password submitted")
            native.setKeyboardFocus( nil )
            --handleButtonEvent({phase="ended", target={id="login"}})
        end
    elseif ("displayName" == event.target.id) then
        --infoUpdate("displayName")
        if ("submitted" == event.phase or "ended" == event.phase) then
            --infoUpdate("displayName submitted")
            native.setKeyboardFocus( nil )
            --handleButtonEvent({phase="ended", target={id="login"}})
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
        username = native.newTextField(w/2, h * .1, w/1.4, h/20)
        username.placeholder = "(Username)"
        username.id = "username"
        username:addEventListener( "userInput", inputListener )

        displayName = native.newTextField(w/2, h * .2, w/1.4, h/20)
        displayName.placeholder = "(Display Name)"
        displayName.id = "displayName"
        displayName:addEventListener( "userInput", inputListener )

        --password = native.newTextField(w/2, 2 * username.y, w/1.4, h/20)
        password = native.newTextField(w/2, h * .3, w/1.4, h/20)
        password.placeholder = "(Password)"
        password.id = "password"
        password.isSecure = true
        password:addEventListener( "userInput", inputListener )
 

        local loginButton = widget.newButton({
            id = "login",
            x = w / 2,
            y = h * .4,
            width = w/1.4,
            height = 2 * username.height,
            label = "Create Account",
            fontSize = username.height,
            shape = "roundedRect",
            cornerRadius = username.height * 2 / 3,
            onEvent = handleButtonEvent,
            fillColor = { default={ 0,191,255 }, over={ 0,191,255 } },
        })

        sceneGroup:insert( username )
        sceneGroup:insert( password )
        sceneGroup:insert( loginButton )
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        password:removeSelf()
        username:removeSelf()
        displayName:removeSelf()
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