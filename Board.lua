--TODO: Refactor functions using (x,y) instead of Point

local Town = require("Town")
local Cell = require("Cell")
local Point = require("Point")
local State = require("State")
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
	__tostring = function(o)
		local t = {}
		table.insert(t, "{id:")

		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId =		function(self) return self._id end,
	getX =		function(self) return self._x end,
	getY =		function(self) return self._y end,
	getCell =	function(self, point)
		-- TODO: Adjust this to work with new Point class
		if x < 1 or y < 1 or x > self._x or y > self._y then
			return self._border_cell
		else
			return self._cells[x][y]
		end
	end,
	setState =	function(self, x, y, state)
		self._cells[x][y]:setState(state)
	end,
	addCellToRegion = function(self, region_id, x, y)
		self._regions[region_id]:addCell(self:getCell(x, y))
	end,
	removeCellFromRegion = function(self, region_id, x, y)
		self._regions[region_id]:removeCell(self:getCell(x, y))
	end,
	updateNewState = function(self)
		for i,region in ipairs(self._regions) do
			region:updateNewState()
		end
	end,
	updateState = function(self)
		for i,row in ipairs(self._cells) do
			for j,cell in ipairs(row) do
				cell:updateState()
			end
		end
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local Board = {}
	Board._boards = {}
	Board.getBoardById = function(id)
		return Board._board[id]
	end
	Board.new = function(size, town_builder)
		local self = setmetatable({}, object_mt)

		self._id = #Board._boards or 1
		self._size = size
		self._border_cell = Cell(self, nil, nil, nil, State.ZERO)
		self._cells = {}
		self._regions = {}
		self._default_region = Region(self)

		table.insert(self._regions, default_region)

		-- TODO: might need another recursive function here
		-- initialize cells
		for i = 1,x do
			self._cells[i] = {}
			for j = 1,y do
				self._cells[i][j] = Cell(i, j, self._regions[1], empty_state)
				id_count = id_count + 1
				self._regions[1]:addCell(self._cells[i][j])
			end
		end

		for i, row in ipairs(self._cells) do
			for j, cell in ipairs(row) do
				cell:setTown(Town(town_builder, self, cell:getPoint()))
				--cell:setTown(town_type.getTown(self, i, j))
			end
		end

		Board._boards[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_mt.__index = object_idx
setmetatable(Board, class_mt)
return Board






