package.path = package.path .. ";../?.lua;../../src/?.lua;"
-- Computation Stack
local Board = 	require("Board")
local Region = 	require("Region")
local Cell = 		require("Cell")
local Town = 		require("Town")
local Rule = 		require("Rule")
local State = 	require("State")
local TownLock =require("TownLock")
local Point = 	require("Point")

-- Controller Stack
local Session = require("Session")

-- GUI Stack
local Menu = 			require("Menu")
local Menuitem = 	require("Menuitem")
local Palette = 	require("Palette")
local Scrollbar = require("Scrollbar")
local Toolbox = 	require("Toolbox")
local Viewport = 	require("Viewport")


function love.load()
	test = "Blargh"
end

function love.update(dt)

end

function love.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", 10, 10, 100, 100)
end






