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
		table.insert(t, "{id:")				table.insert(t, tostring(o._id))
		table.insert(t, ",point:")			table.insert(t, tostring(o._point))
		table.insert(t, ",old_state:")	table.insert(t, tostring(o._old_state))
		table.insert(t, ",state:")			table.insert(t, tostring(o._state))
		table.insert(t, ",new_state:")	table.insert(t, tostring(o._new_state))
		table.insert(t, ",town:")			table.insert(t, tostring(o._town))
		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId =			function(self) return self._id end,
	getPoint =		function(self) return self._point end,
	getTown =		function(self) return self._town end,
	getOldState =	function(self) return self._old_state end,
	getState =		function(self) return self._state end,
	getNewState =	function(self) return self._new_state end,

	setTown =		function(self, town)			self._town = town end,
	setOldState =	function(self, old_state)	self._old_state = old_state end,
	setState =		function(self, state)		self._state = state end,
	setNewState =	function(self, new_state)	self._new_state = new_state end,

	updateNewState = function(self, new_state)
		self._new_state = new_state or self._state
	end,
	updateState = function(self)
		self._old_state = self._state
		self._state = self._new_state
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local Cell = {}
	Cell._cells = {}
	Cell.getCellById = function(id)
		return Cell._cells[id]
	end
	Cell.getCellsByState = function(state)
		local c = {}
		for _,v in ipairs(Cell._cells) do
			if v._state == state then
				table.insert(c, v)
			end
		end
		return c
	end
	Cell.new = function(point, state)
		local self = setmetatable({}, object_meta)

		self._id = #Cell._cells + 1
		self._point = point
		self._old_state = state
		self._state = state
		self._new_state = state
		-- self._town

		Cell._cells[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Cell, class_meta)
return Cell





