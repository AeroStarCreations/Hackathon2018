--create new map
local userMap = native.NewMapView(0,0,250,400)
userMap.x = display.contentCenterX

local locationText = display.newText(" ", 250, native.SystemFont, 16)
locationText.x = display.contentCenterX

local function locationHandler(event)
    local currentLocation = userMap:getUserLocation()
    if currentLocation.errorCode
        locationText.text = error.Message
    else
        myMap:setCenter( currentLocation.latitude, currentLocation.longitude )
        myMap:addMarker( currentLocation.latitude, currentLocation.longitude )
        userMap.mapType = "standard"
    end
end