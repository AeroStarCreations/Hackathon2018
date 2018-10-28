--------------
-- main.lua --
--------------

----
-- Required libraries
----
local composer = require("composer")
local gamesparks = require("gamesparks")
local localData = require("localData")

----
-- Local data
----
--UNCOMMENT TO REENABLE REGISTRATION
--localData.resetAuthData()
localData.initAuthData()
localData.resetAuthData()
-- localData.setRegistered( false ) -- delete once ready

----
-- Initialize GameSparks
----
gs = gamesparks.init()

local map = require("map")

----
-- Go to first scene
----
if not localData.isRegistered() then
   print( "Is not registered" )
    composer.gotoScene("login")
else
   gamesparks.loginWithUsernameAndPassword( 
       localData.getUsername(),
       localData.getPassword(),
       composer.gotoScene("home")
   )
end
