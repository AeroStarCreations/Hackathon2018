local composer = require( "composer" )
local widget = require( "widget" )
local gs = require( "gamesparks" )
local localData = require( "localData" )

widget.setTheme( "widget_theme_ios7" ) 
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local w = display.actualContentWidth
local h = display.actualContentHeight
local leaderboard
local scoreText
local randomScoreButton
local submitButton
local refreshButton
local backButton
local score

local function onRowRenderListener( event )
    local row = event.row
    local params = row.params
  
    if ( event.row.params ) then
        row.rankText = display.newText( params.rank, 12, 0, native.systemFont, 18)
        row.rankText.anchorX = 0
        row.rankText.anchorY = 0.5
        row.rankText:setFillColor( 0 )
        row.rankText.y = row.height / 2
        row.rankText.x = 10
        
        row.nameText = display.newText( params.username, 12, 0, native.systemFontBold, 18 )
        row.nameText.anchorX = 0.5
        row.nameText.anchorY = 0.5
        row.nameText:setFillColor( 0 )
        row.nameText.y = row.height / 2
        row.nameText.x = row.width / 2
    
        row.scoreText = display.newText( params.score, 12, 0, native.systemFont, 18 )
        row.scoreText.anchorX = 1
        row.scoreText.anchorY = 0.5
        row.scoreText:setFillColor( 0 )
        row.scoreText.y = row.height / 2
        row.scoreText.x = row.width - 10

        row:insert( row.rankText )
        row:insert( row.nameText )
        row:insert( row.scoreText )
    end
end

local function createLeaderboardRows( entries )
    for i, entry in pairs(entries) do
        leaderboard:insertRow{
            rowHeight = h / 20,
            rowColor = { default={ 0.9, 0.9, 0.9 }, over={ 1, 0.5, 0, 0.2 } },
            lineColor = { 69/255, 137/255, 247/255 },
            params = {
               username = entry:getUserName(),
               score = entry:getAttribute("SCORER"),
               rank = entry:getRank()
            }
         }
    end
end

local function retrieveLeaderboard()
    gs.getLeaderboardData( function(entries)
        createLeaderboardRows( entries )
    end)
end

local function generateRandomScore() 
    score = math.random( 1000 )
    scoreText.text = score
end

local function refreshLeaderboard() 
    gs.getLeaderboardData( function(entries)
        leaderboard:deleteAllRows()
        createLeaderboardRows( entries )
    end)
end

local function handleButtonEvent( event )
    if (event.phase == "ended") then
        infoClear()
        infoUpdate( event.target.id .. " pressed" )
        if (event.target.id == "random") then
            generateRandomScore()
        elseif (event.target.id == "submit") then
            gs.postScore( score )
        elseif (event.target.id == "back") then
            composer.gotoScene( composer.getSceneName( "previous" ))
        elseif (event.target.id == "refresh") then
            refreshLeaderboard()
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

    infoClear()
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- ex: before the scene transition begins
        retrieveLeaderboard()
        
        local buttonHeight = h / 20
        local spacing = 15
        local smallButtonWidth = w / 3
        local bigButtonWidth = w/2 - spacing*1.5
        local fontSize = 30

        backButton = widget.newButton({
            id = "back",
            x = spacing + bigButtonWidth/2,
            y = h - buttonHeight/2 - spacing,
            width = bigButtonWidth,
            height = buttonHeight,
            label = "Back",
            fontSize = fontSize,
            shape = "roundedRect",
            cornerRadius = 0.3 * buttonHeight,
            onEvent = handleButtonEvent,
        })

        refreshButton = widget.newButton({
            id = "refresh",
            x = w - spacing - bigButtonWidth/2,
            y = backButton.y,
            widget = bigButtonWidth,
            height = buttonHeight,
            label = "Refresh",
            fontSize = fontSize,
            shape = "roundedRect",
            cornerRadius = 0.3 * buttonHeight,
            onEvent = handleButtonEvent,
        })

        randomScoreButton = widget.newButton({
            id = "random",
            x = backButton.x - backButton.width/2 + smallButtonWidth/2,
            y = backButton.y - backButton.height/2 - buttonHeight/2 - spacing,
            width = smallButtonWidth,
            height = buttonHeight,
            label = "Generate",
            fontSize = fontSize,
            shape = "roundedRect",
            cornerRadius = 0.3 * buttonHeight,
            onEvent = handleButtonEvent,
        })

        submitButton = widget.newButton({
            id = "submit",
            x = refreshButton.x + refreshButton.width/2 - smallButtonWidth/2,
            y = randomScoreButton.y,
            width = smallButtonWidth,
            height = buttonHeight,
            label = "Submit",
            fontSize = fontSize,
            shape = "roundedRect",
            cornerRadius = 0.3 * buttonHeight,
            onEvent = handleButtonEvent,
        })

        scoreText = display.newText({
            x = w / 2,
            y = randomScoreButton.y,
            width = submitButton.x - smallButtonWidth - randomScoreButton.x,
            height = buttonHeight,
            text = "<>",
            fontSize = fontSize,
            align = "center"
        })
        scoreText:setFillColor(69/255, 137/255, 247/255)

        leaderboard = widget.newTableView {
           top = spacing * 3, 
           left = spacing * 2,
           width = w - spacing * 4, 
           height = randomScoreButton.y - buttonHeight/2 - spacing*5,
           onRowRender = onRowRenderListener,
           listener = scrollListener
        }

        sceneGroup:insert( randomScoreButton )
        sceneGroup:insert( submitButton )
        sceneGroup:insert( backButton )
        sceneGroup:insert( refreshButton )
        sceneGroup:insert( scoreText )
        sceneGroup:insert( leaderboard )


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        -- ex: after the scene transition completes
 
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
        scoreText:removeSelf()

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