local Region =	require("Region")
local Town =	require("Town")
local Cell =	require("Cell")
local Point =	require("Point")
local State =	require("State")
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
		-- TODO: Finish
		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {
	getId =		function(self) return self._id end,
	getSize =	function(self) return self._size end,
	getCell =	function(self, point)
		--[[
		local cursor = self._cells
		for i, p in point() do
			if p < 1 or p > self._size[i] then
				return self._border_cell
			else
				cursor = cursor[p]
			end
		end

		return cursor
		--]]
		-- [[ Potential refactoring to a flat array
		local m = self._size[#point]
		local s = point[#point]

		for i = 1,#point do
			if point[i] < 1 or point[i] > self._size[i] then
				return self._border_cell
			end
		end

		for i = 1,#point-1 do
			s = s + ((point[#point-i]-1) * m)
			m = m * self._size[#point-i]
		end
		
		return self._cells[s]
		-- ]]
	end,
	setState =	function(self, point, state)
		self:getCell(point):setState(state)
	end,
	addCellToRegion = function(self, region_id, point)
		self._regions[region_id]:addCell(self:getCell(point))
	end,
	removeCellFromRegion = function(self, region_id, point)
		self._regions[region_id]:removeCell(self:getCell(point))
	end,
	updateNewState = function(self)
		for _,region in ipairs(self._regions) do
			region:updateNewState()
		end
	end,
	updateState = function(self)
		for _,region in ipairs(self._regions) do
			region:updateState()
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
	Board.new = function(size, town_builder, wrapped)
		local self = setmetatable({}, object_meta)

		self._id = #Board._boards + 1
		self._size = size
		self._border_cell = Cell(Point(), State.ZERO)
		self._cells = {}
		self._regions = {}
		self._default_region = Region(self)
		self._wrapped = wrapped			-- TODO: Do something with this tomorrow.

		table.insert(self._regions, default_region)

		--[[ create Board
		local function boardTree(parent, depth, parent_address, dimensions)
			for i = 1, dimensions[depth] do
				local p = parent_address:copy()
				p:push(i)
				if depth < #dimensions then
					local child = {}
					table.insert(parent, child)
					boardTree(child, depth + 1, p, dimensions)
				else
					local cell_node = Cell(p, State.ZERO)
					table.insert(parent, cell_node)
					table.insert(self._default_region, cell_node)
				end
			end
		end
		boardTree(self._cells, 1, Point(), self._size)

		-- setup towns
		local function createTowns(node)
			if node._point then
				local t = Town(town_builder, self, node:getPoint())
				node:setTown(t)
			else
				for i = 1, #node do
					createTowns(node[i])
				end
			end
		end
		createTowns(self._cells)
		--]]
		-- [[ Potential refactoring to a flat array
		local function aTree(tree, size, depth, point)
			for i = 1,size[depth] do
				local p = point:copy()
				p:push(i)

				if depth < #size then
					aTree(tree, size, depth + 1, p)
				else
					table.insert(tree, Cell(p, State.ZERO))
				end
			end
		end
		aTree(self._cells, self._size, 1, Point())

		-- Setup Town for each cell
		for _,c in ipairs(self._cells) do
			local town = Town(town_builder, self, c:getPoint())
			c:setTown( town )
		end
		-- ]]

		Board._boards[self._id] = self
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Board, class_meta)
return Board






