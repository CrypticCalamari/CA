#!/usr/bin/lua

package.path = package.path .. ";../src/?.lua;"
local Point = require("Point")
local lu = require("luaunit")

function testPoint()
	p0 = Point()
	p1 = Point(1)
	p2 = Point(1, 2)
	p3 = Point(1, 2, 3, 4, 5, 6)
	print(p0)
	print(p1)
	print(p2)
	print(p3)
	for i,v in p3() do
		print(v)
	end
	print(#p3)

	lu.assertFalse(p1 == p2)
	lu.assertFalse(p1 == p3)

	p3[2] = 10

	lu.assertTrue(p3[2] == 10)

	p0 = p3:copy()
	lu.assertTrue(p0 == p3)
	
	p1:push(100)
	print(p1)
	p1:push(2)
	print(p1)
	p1:pop()
	print(p1)

	lu.assertTrue(p1 ~= p2)

end

os.exit( lu.LuaUnit.run() )
