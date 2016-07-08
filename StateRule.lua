--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local object_mt = {
	__call = function(o, town_key)
		return o:getNewState(town_key)
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")		table.insert(t, o._id)
		table.insert(t, ",state:")	table.insert(t, o._state)
		table.insert(t, ",rules:[")

		for _,v in pairs(o._rules) do
			table.insert(t, v) table.insert(t, ",")
		end

		table.remove(t)
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId = function(self) return self._id end,
	getState = function(self) return self._state end,
	getNewState = function(self, town_key)
		if self._rules[town_key] then
			return self._rules[town_key]:getNewState()
		else
			return nil
		end
	end,
	containsRuleFor = function(self, town_key)
		if self._rules[town_key] then
			return true
		else
			return false
		end
	end,
	getRuleFor = function(self, town_key)
		return self._rules[town_key]
	end,
	setRuleFor = function(self, town_key, rule)
		self._rules[town_key] = rule
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local StateRule = {}
	StateRule._state_rules = {}
	StateRule.getStateRuleById = function(id)
		return StateRule._state_rules[id]
	end
	StateRule.getStateRulesByState = function(state)
		local sr = {}
		for _,v in ipairs(StateRule._state_rules) do
			if v._state == state then
				table.insert(sr, v)
			end
		end
		return sr
	end
	StateRule.getStateRulesWith = function(rule)
		local sr = {}
		for _,v in ipairs(StateRule._state_rules) do
			for _,r in pairs(v._rules) do
				if r == rule then
					table.insert(sr, v)
				end
			end
		end
		return sr
	end
	StateRule.new = function(state)
		local self = setmetatable({}, object_mt)

		self._id = #StateRule._state_rules or 1
		self._state = state
		self._rules = {}

		StateRule[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_mt.__index = object_idx
setmetatable(StateRule, class_mt)
return StateRule






