local Cell = require("Cell")
local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_mt = {
	__tostring = function(object)
		local fiber = "{\n"

		fiber = fiber.."\taddress:"..object._address..",\n"
		fiber = fiber.."\tid:"..object._id..",\n"
		fiber = fiber.."\tx:"..object._x..",\n"
		fiber = fiber.."\ty:"..object._y..",\n"
		fiber = fiber.."\tborder_cell:"..object._border_cell._address..",\n"
		fiber = fiber.."\tboard:\n\t[\n"

		for i = 1,object._x do
			fiber = fiber.."\t\t[\n"
			for j = 1,object._y do
				fiber = fiber.."\t\t\t"..object._board[i][j]._address..",\n"
			end
			fiber = string.sub(fiber, 1, #fiber-2)
			fiber = fiber.."\n\t\t],\n"
		end
		fiber = string.sub(fiber, 1, #fiber-2)
		fiber = fiber.."\n\t],\n\tregion:\n\t[\n"

		for i,region in ipairs(object._region) do
			fiber = fiber.."\t\t"..region._address..",\n"
		end
		fiber = string.sub(fiber, 1, -2)
		fiber = fiber.."\n\t]\n}\n"

		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end,
	getX = function(self) return self._x end,
	getY = function(self) return self._y end,
	getCell = function(self, x, y)
		-- TODO: add type checking
		if x < 1 or y < 1 or x > self._x or y > self._y then
			return nil
		else
			return self._board[x][y]
		end
	end,

	setState = function(self, x, y, state)
		self._board[x][y]:setState(state)
	end,
	addCellToRegion = function(self, x, y, region_id)
		self._region[region_id]:addCell(self:getCell(x, y))
	end,
	removeCellFromRegion = function(self, x, y, region_id)
		self._region[region_id]:removeCell(self:getCell(x, y))
	end,
	updateNewState = function(self)
		for i,region in ipairs(self._region) do
			region:updateNewState()
		end
	end,
	updateState = function(self)
		for i,row in ipairs(self._board) do
			for j,cell in ipairs(row) do
				cell:updateState()
			end
		end
	end
}
local Board = {
	new = function(id, x, y, init_region, empty_state, border_cell, town_type)
		local self = {}

		self._address = tostring(self)
		self._id = id
		self._x = x
		self._y = y
		self._border_cell = border_cell
		self._board = {}
		self._region = {}

		setmetatable(self, object_mt)

		-- initialize cells
		id_count = 1
		for i = 1,x do
			self._board[i] = {}
			for j = 1,y do
				self._board[i][j] = Cell(id_count, i, j, init_region, empty_state)
				id_count = id_count + 1
				init_region:addCell(self._board[i][j])
			end
		end

		table.insert(self._region, init_region)

		r = 1		-- TODO: Extract magic variable
		for i, row in ipairs(self._board) do
			for j, cell in ipairs(row) do
				cell:setTown(town_type.getTown(self, border_cell, i, j, r))
			end
		end

		return self
	end
}
object_mt.__index = object_idx
setmetatable(Board, class_mt)
return Board






