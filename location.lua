v = {}

local longitude
local latitude
local isKnown = false

local function locationHandler( event )
    if (event.errorCode == nil) then
        latitude = event.latitude
        longitude = event.longitude
        isKnown = true;
    end
end

v.init = function() 
    Runtime:addEventListener( "location", locationHandler )
end

v.close = function()
    Runtime:removeEventListener( "location", locationHandler )
end

v.get = function( callback )
    return {
        latitude = latitude,
        longitude = longitude
    }
end

v.waitForLocation = function( callback )
    Runtime:addEventListener( "location", callback )
end

v.isKnown = function()
    return isKnown
end

return v