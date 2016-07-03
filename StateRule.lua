local class_mt = {}
local object_mt = {}
local object_idx = {}
local StateRule = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return left._id == right._id
end
function object_mt.__tostring(object)
	local the_string = "{"

	

	return the_string
end

function object_idx:getId() return self._id end
function object_idx:getState() return self._state end
function object_idx:containsRuleFor(town_key)
	if self._rule[town_key] then
		return true
	end
	return false
end
function object_idx:getRuleFor(town_key)
	return self._rule[town_key]
end
function object_idx:setRuleFor(town_key, rule)
	self._rule[town_key] = rule
end
function object_idx:getNewState(town_key)
	if self._rule[town_key] then
		return self._rule[town_key]:getNewState()
	end

	return nil
end

function StateRule.new(id, state)
	local self = {}

	self._address = tostring(self)
	self._id = id
	self._state = state
	self._rule = {}		-- list of rules that cause a state change

	setmetatable(self, object_mt)

	return self
end

return StateRule





