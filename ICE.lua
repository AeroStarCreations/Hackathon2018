--File to create the scene for the ICE screen
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

local function handleButtonEvent( event )
    if (event.phase == "ended") then
        print("First Condition")
        if (event.target.id == "addButton") then
            print("Adding Contact")
            composer.gotoScene("addContact")
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

        local addButton = widget.newButton({
            id = "addButton",
            x = w / 2,
            y = h * .8,
            width = w/1.4,
            height = 2 * (h/20),
            label = "Add ICE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            fillColor = { default={ 200, 0, 0 }, over={ 200, 0, 0 } },
            labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } },
            onEvent = handleButtonEvent,
            --onRelease = btnPressed
        })

        local contactTable = widget.newTableView({
            id = "contactTable",
            left = w/8,
            top = h * .1,
            isBounceEnabled = true,
            width = w/ 1.3,
            height = h * .6,
            fillColor = {default={255,255,255}, over={255,255,255}}
            
        })
        local isCategory = false
    local rowHeight = 36
    local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
    local lineColor = { 0.5, 0.5, 0.5 }
        contactTable:insertRow(
        {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor,
            params = {
                name = "Nate",
                number = "12345678902"
            }  -- Include custom data in the row
        }
    )

        sceneGroup:insert( addButton )
        sceneGroup:insert( contactTable )
        --addButton.labelColor = { default={ 0, 200, 0 }, over={ 0, 0, 0, 0.5 } }
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