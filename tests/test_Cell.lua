#!/usr/bin/lua

package.path = package.path .. ";../src/?.lua;"
local Cell = require("Cell")
local Point = require("Point")
local State = require("State")
local lu = require("luaunit")

function testCell()
	c1 = Cell({}, Point(0, 0), State.ZERO) 

	c1:updateState()

	print(c1)
end

os.exit( lu.LuaUnit.run() )
