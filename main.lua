--------------
-- main.lua --
--------------

----
-- Required libraries
----
local composer = require("composer")
local gamesparks = require("gamesparks")

----
-- Go to first scene
----
composer.gotoScene("login")

----
-- Initialize GameSparks
----
gs = gamesparks.init()
