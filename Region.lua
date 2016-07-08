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
	__call = function(o, state)
		return self._state_rules[ state:getId() ]
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")		table.insert(t, tostring(o._id))
		table.insert(t, ",board:") table.insert(t, tostring(o._board._id))
		table.insert(t, ",cells:[")				-- TODO: Finish this function
		table.insert(t, ",state_rules:[")
		table.insert(t, ",lock_types:[")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	contains = function(self, cell)
		if self._cells[cell:getId()] then
			return true
		end
		return false
	end,
	getId = function(self) return self._id end,
	getStateRule = function(self, state)
		if not self._state_rules[state:getId()] then
			error("Find better way to handle nil _state_rules[state_id] in Region")
		end
		return self._state_rules[state:getId()]
	end,
	getLockType = function(self, state)
		if not self._lock_types[state:getId()] then
			error("Find better way to handle nil _lock_types[state_id] in Region")
		end
		return self._lock_types[state:getId()]
	end,
	addCell = function(self, cell)
		self._cells[cell:getId()] = cell
	end,
	removeCell = function(self, cell)
		self._cells[cell:getId()] = nil
	end,
	setStateRule = function(self, state, state_rule)
		self._state_rules[state:getId()] = state_rule
	end,
	setLockType = function(self, state, town_locksmith)
		self._lock_types[state:getId()] = town_locksmith
	end,
	updateNewState = function(self)
		for _,cell in pairs(self._cells) do
			cell:updateNewState(self)
		end
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local Region = {}
	Region._regions = {}
	Region.getRegionById = function(id)
		return Region._regions[id]
	end
	Region.getRegionContainingCell = function(cell)
		for _,r in ipairs(Region._regions) do
			if r._cells[cell:getId()] then
				return r
			end
		end
	end
	Region.new = function(board)
		local self = setmetatable({}, object_meta)

		self._id = #Region._regions or 1
		self._board = board
		self._cells = {}
		self._state_rules = {}
		self._lock_types = {}

		Region._regions[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Region, class_meta)
return Region





