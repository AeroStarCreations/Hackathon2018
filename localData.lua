local GGData = require( "GGData" )

----
-- Representations
----

-- appData = {
--     username = string,
--     password = string,
--     isRegistered = boolean
-- }

----
-- Local variables
----
local TAG = "localData.lua : "
local data = GGData:new( "appData" )

local function methodToString()
    local text = ""
    for k,v in pairs(data:get("signInMethod")) do
        if v then
            text = text .. k .. " "
        end
    end
    return text
end

----
-- return table
----
local v = {}

function v.initAuthData()
    data:setIfNew( "username", "")
    data:setIfNew( "password", "" )
    data:setIfNew( "isRegistered", false)
    data:save()
end

function v.getUsername()
    return data:get( "username" )
end

function v.setUsername( username )
    data:set( "username", username )
    data:save()
end

function v.getPassword()
    return data:get( "password" )
end

function v.setPassword( password )
    data:set( "password", password )
    data:save()
end

function v.setRegistered()
    data:set( "isRegistered", true)
    data:save()
end

function v.isRegistered()
    return data:get( "isRegistered" )
end

function v.resetAuthData()
    data:set( "username", "" )
    data:set( "password", "" )
    data:set( "isRegistered", false )
    data:save()
end

function v.printAuthData()
    local text = "username=" .. "\"" .. v.getUsername() .. "\"\n"
    text = text .. "\t\t\t" .. "password=" .. "\"" .. v.getPassword() .. "\""
    print( TAG, text )
end

return v