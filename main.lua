local ca = require("CA")

function love.load()
	x = 100
	y = 100
	empty_state = ca.State(0, 0)
	full_state = ca.State(1, 1)

	empty_state_rule = ca.StateRule(0, empty_state)
	full_state_rule = ca.StateRule(1, full_state)

	--empty_state_rule:setRuleFor(0, ca.Rule(0, 0, full_state))
	empty_state_rule:setRuleFor(1, ca.Rule(1, 1, full_state))
	empty_state_rule:setRuleFor(2, ca.Rule(2, 2, full_state))
	--empty_state_rule:setRuleFor(3, ca.Rule(3, 3, full_state))
	--empty_state_rule:setRuleFor(4, ca.Rule(4, 4, full_state))
	--empty_state_rule:setRuleFor(5, ca.Rule(5, 5, full_state))
	--empty_state_rule:setRuleFor(6, ca.Rule(6, 6, full_state))
	--empty_state_rule:setRuleFor(7, ca.Rule(7, 7, full_state))
	--empty_state_rule:setRuleFor(8, ca.Rule(8, 8, full_state))

	full_state_rule:setRuleFor(0, ca.Rule(9, 0, empty_state))
	full_state_rule:setRuleFor(1, ca.Rule(10, 1, empty_state))
	--full_state_rule:setRuleFor(2, ca.Rule(11, 2, empty_state))
	full_state_rule:setRuleFor(3, ca.Rule(12, 3, empty_state))
	--full_state_rule:setRuleFor(4, ca.Rule(13, 4, empty_state))
	full_state_rule:setRuleFor(5, ca.Rule(14, 5, empty_state))
	--full_state_rule:setRuleFor(6, ca.Rule(15, 6, empty_state))
	full_state_rule:setRuleFor(7, ca.Rule(16, 7, empty_state))
	--full_state_rule:setRuleFor(8, ca.Rule(17, 8, empty_state))

	init_region = ca.Region(0)

	init_region:addStateRule(0, empty_state_rule)
	init_region:addStateRule(1, full_state_rule)

	init_region:addStateTownKeyGen(0, ca.TownKeyGenSum)
	init_region:addStateTownKeyGen(1, ca.TownKeyGenSum)

	border_cell = ca.Cell(0, 0, 0, init_region, empty_state)
	board = ca.Board(0, x, y, init_region, empty_state, border_cell, ca.MooreTown)

	--[[ Glider
	board:setState(1, 2, full_state)
	board:setState(2, 3, full_state)
	board:setState(3, 1, full_state)
	board:setState(3, 2, full_state)
	board:setState(3, 3, full_state)
	]]

	board:setState(20, 40, full_state)
	board:setState(20, 41, full_state)
	board:setState(20, 42, full_state)
	board:setState(20, 43, full_state)
	board:setState(20, 44, full_state)

	display = {}
	display.width = 1000
	display.height = 1000
	display.draw = function()
		for i = 1,x do
			for j = 1,y do
				if board:getCell(i, j):getState():getValue() == 0 then
					love.graphics.setColor(0, 0, 0)
				else
					love.graphics.setColor(255, 255, 255)
				end
				love.graphics.rectangle("fill", (j-1) * 5, (i-1) * 5, 5, 5, 2)
			end
		end
	end

	session = {}
	session.stepSpeed = 4
	session.tillNextStep = session.stepSpeed
	session.step = function()
		if session.tillNextStep <= 0 then
			session.tillNextStep = session.stepSpeed
			board:updateNewState()
			board:updateState()
			display.draw()
		end
	end

	display.draw()
end

function love.update(dt)
	session.tillNextStep = session.tillNextStep - 1
	session.step()
end

function love.draw()
	display.draw()
end






