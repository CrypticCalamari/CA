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
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")		table.insert(t, tostring(o._id))
		table.insert(t, ",value:")	table.insert(t, tostring(o._value))
		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId = function(self) return self._id end,
	getValue = function(self) return self._value end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local State = {}; setmetatable(State, class_meta)

	State._states = {}
	State.getStateById = function(id)
		return State._states[id]
	end
	State.getStatesByValue = function(value)
		local s = {}
		for _,v in ipairs(State._states) do
			if v._value == value then
				table.insert(s, v)
			end
		end
		return s
	end
	State.new = function(value)
		local self = setmetatable({}, object_meta)
	
		self._id = #State._states + 1
		self._value = value
	
		State._states[self._id] = self
		return self
	end
	State.ZERO = State(0)
	State.ONE = State(1)
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
return State





