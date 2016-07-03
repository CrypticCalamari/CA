local class_mt = {}
local object_mt = {}
local object_idx = {}
local Region = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return left._id == right._id
end
function object_mt.__tostring(object)
	local the_string = "{"

	the_string = the_string.."address:"..object._address..", "
	the_string = the_string.."id:"..object._id..", "
	-----------------------------
	the_string = the_string.."region:["
	for i,cell in ipairs(object._region) do
		the_string = the_string..cell..", "			-- TODO: Find some way to clean up trailing comma on last array entry
	end
	if string.sub(the_string, -2) == ", " then
		the_string = string.sub(the_string, 1, #the_string-2)
	end
	-----------------------------
	the_string = the_string.."], state_rule:["

	for i,state_rule in ipairs(object._state_rule) do
		the_string = the_string..state_rule..", "			-- TODO: overload __tostring in StateRule
	end
	if string.sub(the_string, -2) == ", " then
		the_string = string.sub(the_string, 1, #the_string-2)
	end
	-----------------------------
	the_string = the_string.."], state_town_key_gen:["

	for i,state_town_key_gen in ipairs(object._state_town_key_gen) do
		the_string = the_string..state_town_key_gen..", "
	end
	if string.sub(the_string, -2) == ", " then
		the_string = string.sub(the_string, 1, #the_string-2)
	end
	-----------------------------
	the_string = the_string.."]}"

	return the_string
end

function object_idx:getId() return self._id end
function object_idx:contains(cell)
	if self._region[cell:getId()] then
		return true
	end
	return false
end
function object_idx:addCell(cell)
	self._region[cell:getId()] = cell
end
function object_idx:removeCell(cell)
	self._region[cell:getId()] = nil
end
function object_idx:addStateRule(state_id, state_rule)
	self._state_rule[state_id] = state_rule
end
function object_idx:removeStateRule(state_id)
	self._state_rule[state_id] = nil
end
function object_idx:addStateTownKeyGen(state_id, town_key_gen)
	self._state_town_key_gen[state_id] = town_key_gen
end
function object_idx:removeStateTownKeyGen(state_id)
	self._state_town_key_gen[state_id] = nil
end
function object_idx:updateNewState()
	for k, cell in pairs(self._region) do
		cell_state_id = cell:getState():getId()
		town_key = self._state_town_key_gen[cell_state_id].getTownKey(cell)
		new_state = self._state_rule[cell_state_id]:getNewState(town_key)

		cell:setNewState(new_state or cell:getState())
	end
end

function Region.new(id)
	local self = {}

	self._address = tostring(self)
	self._id = id
	self._region = {}
	self._state_rule = {}
	self._state_town_key_gen = {}

	setmetatable(self, object_mt)

	return self
end

return Region





