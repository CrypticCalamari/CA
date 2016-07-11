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
		return self._rules[ state:getId() ]
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")		table.insert(t, tostring(o._id))
		table.insert(t, ",board:") table.insert(t, tostring(o._board._id))
		table.insert(t, ",cells:[")				-- TODO: Finish this function
		table.insert(t, ",rules:[")
		table.insert(t, ",town_locks:[")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	containsCell = function(self, cell)
		return not not self._cells[cell:getId()]
	end,
	getId = 			function(self)				return self._id end,
	getRule = 		function(self, state)	return self._rules[state:getId()] end,
	getTownLock =	function(self, state)	return self._town_locks[state:getId()] end,

	addCell =		function(self, cell)		self._cells[cell:getId()] = cell end,
	removeCell =	function(self, cell)		self._cells[cell:getId()] = nil end,
	setRule =		function(self, state, rule)		self._rules[state:getId()] = rule end,
	setTownLock =	function(self, state, town_lock)	self._town_locks[state:getId()] = town_lock end,
	updateNewState = function(self)
		for _,c in pairs(self._cells) do
			local s_id = c:getState():getId()
			local town_key = self._town_locks[s_id](c:getTown())
			c:updateNewState( self._rules[s_id](town_key) )
		end
	end,
	updateState = function(self)
		for _,c in pairs(self._cells) do
			c:updateState()
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

		self._id = #Region._regions + 1
		self._board = board
		self._cells = {}
		self._rules = {}
		self._town_locks = {}

		Region._regions[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Region, class_meta)
return Region





