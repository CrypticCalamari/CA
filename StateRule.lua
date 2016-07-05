local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_mt = {
	__eq = function(left, right)
		return left._id == right._id
	end,
	__tostring = function(object)
		local fiber = "{"
		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end,
	getState = function(self) return self._state end,
	containsRuleFor = function(town_key)
		if self._rules[town_key] then
			return true
		end
		return false
	end,
	getRuleFor = function(town_key)
		return self._rules[town_key]
	end,
	setRuleFor = function(town_key, rule)
		self._rules[town_key] = rule
	end,
	getNewState = function(town_key)
		if self._rules[town_key] then
			return self._rules[town_key]:getNewState()
		end

		return nil
	end
}
local StateRule = {
	new = function(id, state)
		local self = {}

		self._address = tostring(self)
		self._id = id
		self._state = state
		self._rules = {}		-- list of rules that cause a state change

		setmetatable(self, object_mt)
		return self
	end
}
object_mt.__index = object_idx
setmetatable(StateRule, class_mt)
return StateRule





