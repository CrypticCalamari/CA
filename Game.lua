local Board = require("Board")
local Region = require("Region")
local Cell = require("Cell")
local MooreTown = require("MooreTown")
local State = require("State")
local StateRule = require("StateRule")
local Rule = require("Rule")
local TownKeyGenSum = require("TownKeyGenSum")

local empty_state = State(0, 0)
local full_state = State(1, 1)

local empty_state_rule = StateRule(0, empty_state)
local full_state_rule = StateRule(1, full_state)

empty_state_rule:setRuleFor(3, Rule(0, 3, full_state))
full_state_rule:setRuleFor(0, Rule(1, 0, empty_state))
full_state_rule:setRuleFor(1, Rule(2, 1, empty_state))
full_state_rule:setRuleFor(4, Rule(3, 4, empty_state))
full_state_rule:setRuleFor(5, Rule(4, 5, empty_state))
full_state_rule:setRuleFor(6, Rule(5, 6, empty_state))
full_state_rule:setRuleFor(7, Rule(6, 7, empty_state))
full_state_rule:setRuleFor(8, Rule(7, 8, empty_state))

local init_region = Region(0)

init_region:addStateRule(0, empty_state_rule)
init_region:addStateRule(1, full_state_rule)

init_region:addStateTownKeyGen(0, TownKeyGenSum)
init_region:addStateTownKeyGen(1, TownKeyGenSum)

local border_cell = Cell(0, 0, 0, init_region, empty_state)
local board = Board(0, 4, 4, init_region, empty_state, border_cell, MooreTown)

board:setState(1, 2, full_state)
board:setState(2, 3, full_state)
board:setState(3, 1, full_state)
board:setState(3, 2, full_state)
board:setState(3, 3, full_state)

print(board)

for i = 1,4 do
	for j = 1,4 do
		print(board:getCell(i, j):getState())
	end
end

function start()
	while true do
		local board_print = ""
		for i = 1,4 do
			for j = 1,4 do
				
				if board:getCell(i, j):getState():getValue() == 0 then
					board_print = board_print.."-"
				else
					board_print = board_print.."@"
				end
				
				--board_print = board_print..TownKeyGenSum.getTownKey(board:getCell(i, j))
			end
			board_print = board_print.."\n"
		end
		print(board_print)

		board:updateNewState()
		board:updateState()

		os.execute("sleep 1")	-- TODO: Use more effective sleep supplements
	end
end

start()






