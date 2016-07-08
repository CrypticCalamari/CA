local TownLocksmith = require("TownLocksmith")

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
	__tostring = function(object)
		local fiber = {}
		table.insert(fiber, "{id:")			table.insert(fiber, object._id)
		table.insert(fiber, ",point:")		table.insert(fiber, object._point)
		table.insert(fiber, ",old_state:")	table.insert(fiber, object._old_state)
		table.insert(fiber, ",state:")		table.insert(fiber, object._state)
		table.insert(fiber, ",new_state:")	table.insert(fiber, object._new_state)
		table.insert(fiber, ",town:[")
		if object._town then
			for i,c in ipairs(object._town) do
				table.insert(fiber, c._id)
				if i < #object._town then
					table.insert(fiber, ",")
				end
			end
		end
		table.insert(fiber, "]}")
		return fiber
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId =			function(self) return self._id end,
	getPoint =		function(self) return self._point end,
	getRegion =		function(self) return self._region end,
	getTown =		function(self) return self._town end,
	getOldState =	function(self) return self._old_state end,
	getState =		function(self) return self._state end,
	getNewState =	function(self) return self._new_state end,

	setRegion =		function(self, region)		self._region = region end,
	setTown =		function(self, town)			self._town = town end,
	setOldState =	function(self, old_state)	self._old_state = old_state end,
	setState =		function(self, state)		self._state = state end,
	setNewState =	function(self, new_state)	self._new_state = new_state end,

	updateNewState = function(self, region)
		local town_key = TownLocksmith(region:getLockType(state), self._town)
		self._new_state = region(self._state)(town_key)
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
	Cell.new = function(board, region, point, state)
		local self = setmetatable({}, object_mt)

		self._id = #Cell._cells or 1
		self._board = board
		self._region = region
		self._point = point
		self._old_state = state
		self._state = state
		self._new_state = state
		self._town = nil			-- self._town set after Cell creation

		Cell._cells[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_mt.__index = object_idx
setmetatable(Cell, class_mt)
return Cell





