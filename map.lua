-- create new map

local gamesparks = require("gamesparks")
local json = require("json")
local clock 
local class = {}
local userMap = native.newMapView(70,250,750, 900)
-- userMap:setMarker(-37.87823, 170.23434)
-- if userMap == nil then
--     local text = display.newText("Error", 200, 250, native.SystemFont, 16)
-- end

local locationText = display.newText("Location: ", 0, 250, native.SystemFont, 16)
locationText.x = display.contentCenterX

local function locationHandler(event)
    local player = gamesparks.getPlayer()
    if (not player == null) then
        timer.cancel(clock)
        local currentLocation = player.getLocation()
        print(json.prettify(currentLocation))
        local locationText = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longditute
        userMap:setCenter(currentLocation.latitude, currentLocation.longditute)
        userMap:setMarker(currentLocation.latitude, currentLocation.longditute)
        userMap.mapType = "standard"
        -- local currentLocation = userMap:getUserLocation()
        -- if currentLocation.errorCode then
        --     locationText.text = error.Message 
        -- else
        --     locationText.text = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longitude
        --     userMap:setCenter( currentLocation.latitude, currentLocation.longitude )
        --     -- userMap:setMarker( currentLocation.latitude, currentLocation.longitude)
        --     userMap.mapType = "standard"
    end
end

clock = timer.performWithDelay(500, locationHandler, -1)

return class
