#!/usr/bin/lua

package.path = package.path .. ";../src/?.lua;"
local Rule = require("Rule")
local State = require("State")
local lu = require("luaunit")

function testRule()
	Rule.ZERO = Rule(State.ZERO)
	Rule.ONE = Rule(State.ONE)

	--[[ The code below will appear similarly in the RuleController for 2D CA to
		test other Rules before implementing the GUI. Specific lines will be
		commented out to create a new ruleset]]
	Rule.ZERO[0] = State.ONE
	Rule.ZERO[1] = State.ONE
	Rule.ZERO[2] = State.ONE
	Rule.ZERO[3] = State.ONE
	Rule.ZERO[4] = State.ONE
	Rule.ZERO[5] = State.ONE
	Rule.ZERO[6] = State.ONE
	Rule.ZERO[7] = State.ONE
	Rule.ZERO[8] = State.ONE

	Rule.ONE[0] = State.ZERO
	Rule.ONE[1] = State.ZERO
	Rule.ONE[2] = State.ZERO
	Rule.ONE[3] = State.ZERO
	Rule.ONE[4] = State.ZERO
	Rule.ONE[5] = State.ZERO
	Rule.ONE[6] = State.ZERO
	Rule.ONE[7] = State.ZERO
	Rule.ONE[8] = State.ZERO

	print(Rule.ONE:getId())
	print(Rule.ONE:getState())
	print(Rule.ONE[5])

	for k,v in ipairs(Rule._rules) do
		print(Rule._rules)
	end
	print("-------------------------------")
	print(Rule.getRuleById(1))
	for _,v in ipairs(Rule.getRulesByState(State.ZERO)) do
		print(v)
	end
	for _,v in ipairs(Rule.getRulesByNewState(State.ONE)) do
		print(v)
	end
end

os.exit( lu.LuaUnit.run() )
