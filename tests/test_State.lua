#!/usr/bin/lua

package.path = package.path .. ";../src/?.lua;"
local State = require("State")
local lu = require("luaunit")

function testState()
	print(State.ZERO)
	print(State.ONE)
	s1 = State(1)
	print(s1)
	print("-------------")
	s2 = State(2)
	s3 = State(1)

	lu.assertEquals(s1, s1)
	lu.assertNotEquals(s1:getValue(), s2:getValue())
	lu.assertEquals(s1:getValue(), s3:getValue())

	lu.assertFalse(s1 == s2)
	lu.assertFalse(s1 == s3)

	for _,v in ipairs(State._states) do
		print(v)
	end
end

os.exit( lu.LuaUnit.run() )
