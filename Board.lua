local Cell = require("Cell")

local class_mt = {}
local object_mt = {}
local object_idx = {}
local Board = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end

function object_mt.__tostring(object)
	local the_string = "{\n"

	the_string = the_string.."\taddress:"..object._address..",\n"
	the_string = the_string.."\tid:"..object._id..",\n"
	the_string = the_string.."\tx:"..object._x..",\n"
	the_string = the_string.."\ty:"..object._y..",\n"
	the_string = the_string.."\tborder_cell:"..object._border_cell._address..",\n"
	the_string = the_string.."\tboard:\n\t[\n"

	for i = 1,object._x do
		the_string = the_string.."\t\t[\n"
		for j = 1,object._y do
			the_string = the_string.."\t\t\t"..object._board[i][j]._address..",\n"
		end
		the_string = string.sub(the_string, 1, #the_string-2)
		the_string = the_string.."\n\t\t],\n"
	end
	the_string = string.sub(the_string, 1, #the_string-2)
	the_string = the_string.."\n\t],\n\tregion:\n\t[\n"

	for i,region in ipairs(object._region) do
		the_string = the_string.."\t\t"..region._address..",\n"
	end
	the_string = string.sub(the_string, 1, -2)
	the_string = the_string.."\n\t]\n}\n"

	return the_string
end

function object_idx:getId() return self._id end
function object_idx:getX() return self._x end
function object_idx:getY() return self._y end
function object_idx:getCell(x, y)
	-- TODO: add type checking
	if x < 1 or y < 1 or x > self._x or y > self._y then
		return nil
	else
		return self._board[x][y]
	end
end
function object_idx:setState(x, y, state)
	self._board[x][y]:setState(state)
end
function object_idx:addCellToRegion(x, y, region_id)
	self._region[region_id]:addCell(self:getCell(x, y))
end
function object_idx:removeCellFromRegion(x, y, region_id)
	self._region[region_id]:removeCell(self:getCell(x, y))
end
function object_idx:updateNewState()
	for i,region in ipairs(self._region) do
		region:updateNewState()
	end
end
function object_idx:updateState()
	for i,row in ipairs(self._board) do
		for j,cell in ipairs(row) do
			cell:updateState()
		end
	end
end

function Board.new(id, x, y, init_region, empty_state, border_cell, town_type)
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

return Board






