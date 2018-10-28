local GS = require( "plugin.gamesparks" )
local json = require( "json" )

----
-- Local variables
----
local TAG = "gamesparks.lua : "
local gs = nil
local player = nil
local requestBuilder

local function createRequestBuilder()
    requestBuilder = gs.getRequestBuilder()
end

local function getLogOutRequest()
    return requestBuilder.createLogEventRequest()
end

local function getLogEventRequest()
    return requestBuilder.createLogEventRequest()
end

local function getUsernameLoginRequest()
    return requestBuilder.createAuthenticationRequest()
end

local function getRegistrationRequest()
    return requestBuilder.createRegistrationRequest()
end

local function getAccountDetailsRequest()
    return requestBuilder.createAccountDetailsRequest()
end

local function printErrors( errors )
    print( TAG )
    print( TAG, " - ERRORS -" )
    for k,v in pairs(errors) do
        print( TAG, k, v )
    end
    print( TAG )
end

local function createAccountDetailsRequest()
    if gs.isAuthenticated() then
        print( TAG, "User is authenticated" )
        playerDetails = getAccountDetailsRequest()
        playerDetails:send( function(response)
            print( TAG, " - ACCOUNT DETAILS - ")
            print( TAG, json.prettify(response) )
            if (not response:hasErrors()) then
                print( TAG, "Account details retrieval SUCCESS" )
                player = response.data
                -- infoUpdate( "Welcome, "..player.displayName.."!" )
            else
                printErrors( response:getErrors() )
            end
        end)
    end
end

local function availabilityCallback( isAvailable ) 
    print( TAG, "Availability=" .. tostring(isAvailable) )

    if isAvailable then
        createAccountDetailsRequest()
    end
end

local function authenticatedCallback( playerId )
    print( TAG, "Authentication playerId=" .. tostring(playerId) )

    if playerID then
        print( TAG, "playerId=" .. playerId )
    else
        print( TAG, "GameSparks not authenticated" )
    end
end

local function writeText( message ) 
    print(message)
end

----
-- Return object
----
local v = {}

function v.init()
    gs = createGS()
    gs.setLogger( writeText )
    gs.setApiKey( "L371527JngiM" )
    gs.setApiSecret( "RLDvp4Nj5BZg98BWXTX7ZzbdoGyy3Zoq" )
    gs.setApiCredential( "device" )
    gs.setUseLiveServices( false )
    gs.setAvailabilityCallback( availabilityCallback )
    gs.setAuthenticatedCallback( authenticatedCallback )
    gs.connect()
    createRequestBuilder()
    return gs
end

function v.getPlayer()
    return player
end

function v.logOut()
    local logoutRequest = getLogOutRequest()
    logoutRequest:setEventKey( "Log_Out" )
    logoutRequest:send( function(response)
        print( TAG, "Logout request response" )
        localData.resetAuthData()
        if (not response:hasErrors()) then
            print( TAG, "Logout successful" )
            player = nil
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.loginWithUsernameAndPassword( username, password )
    local loginRequest = getUsernameLoginRequest()
    loginRequest:setUserName( username )
    loginRequest:setPassword( password )
    loginRequest:send( function(response)
        print( TAG, "Login request sent" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks login with username SUCCESS" )
            -- localData.setAuthData( "username", true, response:getAuthToken() )
            createAccountDetailsRequest()
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.registerWithUsernameAndPassword( displayName, username, password )
    local registerRequest = getRegistrationRequest()
    registerRequest:setDisplayName( displayName )
    registerRequest:setUserName( username )
    registerRequest:setPassword( password )
    registerRequest:send( function(response)
        print( TAG, "Register request response" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks registration with username SUCCESS" )
            -- localData.setAuthData( "username", true, response:getAuthToken() )
            createAccountDetailsRequest()
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.submitUserData( data )
    -- data: color, number, food
    local eventRequest = getLogEventRequest()
    eventRequest:setEventKey( "Set_Player_Data" )
    eventRequest:setEventAttribute( "playerData", data )
    eventRequest:send( function(response)
        print( TAG, "Submit user data response" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks submit data SUCCESS" )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.getUserData( callback )
    local eventRequest = getLogEventRequest()
    eventRequest:setEventKey( "Get_Player_Data" )
    eventRequest:send( function(response)
        print( TAG, "Submit get data response" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks get data SUCCESS" )
            callback( response:getScriptData().playerData )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.postScore( score )
    local postScoreRequest = getLogEventRequest()
    postScoreRequest:setEventKey( "LEADERBOARD_SCORER" )
    postScoreRequest:setEventAttribute( "SCORER", score )
    postScoreRequest:send( function(response)
        print( TAG, "Submit post score response" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks post score SUCCESS" )
            -- infoClear()
            -- infoUpdate( "Score submitted successfully" )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.setStatus( status )
    local statusRequest = getLogEventRequest()
    statusRequest:setEventKey( "Set_Safe" )
    statusRequest:setEventAttribute( "STATUS", status )
    statusRequest:send( function(response)
        print( TAG, "Submit safety status" )
        if (not response:hasErrors()) then
            print( TAG, "Safety status post SUCCESS" )
            -- infoClear()
            -- infoUpdate( "Score submitted successfully" )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.addICEContact( name, number )
    print("Trying to add contacts")
    local addContactRequest = getLogEventRequest()
    addContactRequest:setEventKey( "Add_ICE" )
    addContactRequest:setEventAttribute( "CONTACT", {name=name, number=number} )
    addContactRequest:send( function(response)
        print( TAG, "Add ICE contact" )
        if (not response:hasErrors()) then
            print( TAG, "Add ICE contact SUCCESS" )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.getICEContacts( callback )
    local eventRequest = getLogEventRequest()
    print("Trying to get contacts ICE")
    eventRequest:setEventKey( "Get_ICE" )
    eventRequest:send( function(response)
        print( TAG, "Get ICE contacts response" )
        if (not response:hasErrors()) then
            print( TAG, "GameSparks get ICE contacts SUCCESS" )
            print(json.prettify(response:getScriptData()))
            callback( response:getScriptData().Contacts )
        else
            printErrors( response:getErrors() )
        end
    end)
end

function v.deleteICEContact( number, callback )
    print("Trying to delete a contact")
    local deleteContactRequest = getLogEventRequest()
    deleteContactRequest:setEventAttribute( "NUMBER", {number=number} )
    deleteContactRequest:setEventKey( "Delete_ICE" )
    deleteContactRequest:send ( function(response)
        if (not response:hasErrors()) then
            print( TAG, "GameSparks delete ICE contact SUCCESS")
            callback()
        else
            printErrors( response:getErrors() )
        end
    end)
end
return v