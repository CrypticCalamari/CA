--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local object_meta = {
	__call = function(o)
		return o._new_state
	end,
	__eq = function(left, right)
		return left._town_key == right._town_key
			and left._new_state == right._new_state
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")				table.insert(t, tostring(o._id))
		table.insert(t, ",town_key:")		table.insert(t, tostring(o._town_key))
		table.insert(t, ",new_state:")	table.insert(t, tostring(o._new_state))
		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId = 			function(self) return self._id end,
	getTownKey =	function(self) return self._town_key end,
	getNewState =	function(self) return self._new_state end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local Rule = {}
	Rule._rules = {}
	Rule.getRuleById = function(id)
		return Rule._rules[id]
	end
	Rule.getRulesByTownKey = function(town_key)
		local r = {}
		for _,v in ipairs(Rule._rules) do
			if v._town_key == town_key then
				table.insert(r, v)
			end
		end
		return r
	end
	Rule.getRulesByNewState = function(new_state)
		local r = {}
		for _,v in ipairs(Rule._rules) do
			if v._new_state == new_state then
				table.insert(r, v)
			end
		end
		return r
	end
	Rule.new = function(town_key, new_state)
		local self = setmetatable({}, object_meta)

		self._id = #Rule._rules or 1
		self._town_key = town_key
		self._new_state = new_state
	
		Rule._rules[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Rule, class_meta)
return Rule





