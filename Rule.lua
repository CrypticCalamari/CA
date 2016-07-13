--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local Rule = {}
setmetatable(Rule, class_meta)
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId = function(self) return self._id end,
	getState = function(self) return self._state end
}
--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local object_meta = {
	__call = function(o, town_key)
		return o:getNewState(town_key)
	end,
	__index = function(o, key)
		return object_idx[key] or o._new_states[key]
	end,
	__newindex = function(o, town_key, new_state)
		o._new_states[town_key] = new_state
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")		table.insert(t, o._id)
		table.insert(t, ",state:")	table.insert(t, tostring(o._state))
		table.insert(t, ",new_states:[")

		for _,v in pairs(o._new_states) do
			table.insert(t, tostring(v)) table.insert(t, ",")
		end

		table.remove(t)
		table.insert(t, "]}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
	Rule._rules = {}
	Rule.getRuleById = function(id)
		return Rule._rules[id]
	end
	Rule.getRulesByState = function(state)
		local r = {}
		for _,v in ipairs(Rule._rules) do
			if v._state == state then
				table.insert(r, v)
			end
		end
		return r
	end
	Rule.getRulesByNewState = function(new_state)
		local r = {}
		for i,v in ipairs(Rule._rules) do
			print(i)
			for _,ns in pairs(v._new_states) do
				if ns == new_state then
					table.insert(r, v)
					break
				end
			end
		end
		return r
	end
	Rule.new = function(state)
		local self = {}

		self._id = #Rule._rules + 1
		self._state = state
		self._new_states = {}

		Rule._rules[self._id] = self
		setmetatable(self, object_meta)
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
return Rule






