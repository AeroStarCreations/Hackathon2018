--------------
-- main.lua --
--------------

----
-- Required libraries
----
local composer = require("composer")
local gamesparks = require("gamesparks")
local localData = require("localData")
local location = require("location")

----
-- Local data
----
--UNCOMMENT TO REENABLE REGISTRATION
--localData.resetAuthData()
localData.initAuthData()
-- localData.setRegistered( false ) -- delete once ready

----
-- Initialize GameSparks
----
gs = gamesparks.init()

----
-- Location services
----
system.setLocationAccuracy(10)
location.init()

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
