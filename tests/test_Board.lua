#!/usr/bin/lua

package.path = package.path .. ";../src/?.lua;"
local Board = require("Board")
local Town = require("Town")
local Point = require("Point")
local State = require("State")
local lu = require("luaunit")

function testBoard()
	b = Board( Point(10, 10), Town.VONNEUMANN, false )

	print(b:getCell(Point(2, 5)))

	b:setState(Point(1,1), State.ONE)
	b:setState(Point(1,2), State.ONE)
	b:setState(Point(1,3), State.ONE)
	b:setState(Point(1,4), State.ONE)
	b:setState(Point(1,5), State.ONE)
end

os.exit( lu.LuaUnit.run() )
