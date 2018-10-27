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
-- Go to first scene
----
composer.gotoScene("login")

----
-- Local data
----
localData.initAuthData()

----
-- Initialize GameSparks
----
gs = gamesparks.init()
