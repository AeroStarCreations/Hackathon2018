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
local contactTable
local previousSelectedIndex = -1

local function onRowRenderListener( event )
    local row = event.row
    local params = row.params
    print("I made it into onRowRenerListener")
    if ( event.row.params ) then
        row.nameText = display.newText( params.name, 12, 0, native.systemFont, 18)
        row.nameText.anchorX = 0
        row.nameText.anchorY = 0.5
        row.nameText:setFillColor( 0 )
        row.nameText.y = row.height / 2
        row.nameText.x = 10
        row.isSelected = false -- not selected
        
        
        row.numberText = display.newText( params.number, 12, 0, native.systemFontBold, 18 )
        row.numberText.anchorX = 0.5
        row.numberText.anchorY = 0.5
        row.numberText:setFillColor( 0 )
        row.numberText.y = row.height / 2
        row.numberText.x = row.width / 2


        row:insert( row.nameText )
        row:insert( row.numberText )
    end
end

local function onRowTouchListener(event)
    if (event.phase == "release") then
        local row = event.row
        local params = row.params

        if (row.isSelected) then
            row.nameText:setFillColor(0)
            row.numberText:setFillColor(0)
            row.isSelected = false
        else
            row.nameText:setFillColor(1, 0, 0)
            row.numberText:setFillColor(1, 0, 0)
            row.isSelected = true
        end

        if ((previousSelectedIndex ~= row.index) and (previousSelectedIndex ~=-1)) then
            local previousRow = contactTable:getRowAtIndex(previousSelectedIndex)
            previousRow.nameText:setFillColor(0)
            previousRow.numberText:setFillColor(0)
            row.isSelected = false
        end
        previousSelectedIndex = row.index
    end
end

local function createContactTableRows( entries )
    for number, name in pairs(entries) do
        contactTable:insertRow{
            rowHeight = h / 20,
            rowColor = { default={ 0.9, 0.9, 0.9 }, over={ 1, 0.5, 0, 0.2 } },
            lineColor = { 69/255, 137/255, 247/255 },
            params = {
               name = name,
               number = number
              
            }
         }
    end
end

local function retrieveContacts()
    gamesparks.getICEContacts(function(response)
        createContactTableRows(response)
    end)
    
end

local function deleteAndRerenderTable( number )
    gamesparks.deleteICEContact(number, function()
        gamesparks.getICEContacts( function(response)
            contactTable:deleteAllRows()
            createContactTableRows(response)
        end)
    end)
end

local function handleButtonEvent( event )
    if (event.phase == "ended") then
        print("First Condition")
        if (event.target.id == "addButton") then
            print("Adding Contact")
            composer.gotoScene("addContact")
        elseif (event.target.id == "backButton") then
            composer.gotoScene("home")
        elseif (event.target.id == "deleteButton") then
            if (previousSelectedIndex ~= -1 ) then
                local row = contactTable:getRowAtIndex(previousSelectedIndex)
                local number = row.numberText.text
                deleteAndRerenderTable(number)
            end
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
        local tableHeight = display.actualContentHeight * 0.5

        local addButton = widget.newButton({
            id = "addButton",
            x = w / 2,
            y = h * .6,
            width = w/1.4,
            height = 2 * (h/20),
            label = "Add ICE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            fillColor = { default={ 0.28, 0.85, 0.40 }, over={ 0.38, 0.95, 0.50 } },
            labelColor = { default={ 0 }, over={ 0 } },
            onEvent = handleButtonEvent,
        })

        local deleteButton = widget.newButton({
            id = "deleteButton",
            x = w / 2,
            y = h * .7,
            width = w/1.4,
            height = 2 * (h/20),
            label = "Delete ICE",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            fillColor = { default={ 0.96, 0.20, 0.20 }, over={ 1, 0.30, 0.30 } },
            labelColor = { default={ 0 }, over={ 0 } },
            
            onEvent = handleButtonEvent,
        })

        local backButton = widget.newButton({
            id = "backButton",
            x = w / 2,
            y = h * .8,
            width = w/1.4,
            height = 2 * (h/20),
            label = "Back",
            fontSize = h/20,
            shape = "roundedRect",
            cornerRadius = (h/20) * 2 / 3,
            fillColor = { default={ 0.2, 0.55, 1 }, over={ 0.3, 0.65, 1 } },
            labelColor = { default={ 0 }, over={ 0 } },
            onEvent = handleButtonEvent,
        })

        local topRect = display.newRect(
            display.contentCenterX,
            display.topStatusBarContentHeight * 0.5,
            display.actualContentWidth,
            display.topStatusBarContentHeight
        )
        sceneGroup:insert(topRect)

        contactTable = widget.newTableView({
            x = display.contentCenterX,
            y = tableHeight * 0.5 + display.topStatusBarContentHeight,
            width = display.actualContentWidth,
            height = tableHeight,
            isBounceEnabled = true,
            onRowRender = onRowRenderListener,
            fillColor = {0},
            onRowTouch = onRowTouchListener
            
        })
        local isCategory = false
        local rowHeight = 36
        local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
        local lineColor = { 0.5, 0.5, 0.5 }

        sceneGroup:insert( addButton )
        sceneGroup:insert( contactTable )
        sceneGroup:insert( backButton )
        sceneGroup:insert( deleteButton )
        --addButton.labelColor = { default={ 0, 200, 0 }, over={ 0, 0, 0, 0.5 } }

        retrieveContacts()
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