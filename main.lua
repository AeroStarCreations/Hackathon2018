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
localData.initAuthData()
localData.setRegistered( false ) -- delete once ready

----
-- Initialize GameSparks
----
gs = gamesparks.init()

----
-- Go to first scene
----
if not localData.isRegistered() then
    print("******************")
    composer.gotoScene("login")
else
    gamesparks.loginWithUsernameAndPassword( 
        localData.getUsername(),
        localData.getPassword()
    )
end
