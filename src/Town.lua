--[[////////////////////////////////////
//			Object: Metatable							//
////////////////////////////////////--]]
local object_meta = {
	__call = function(o)
		local i = 0
		local n = #o._cells
		return function()
			i = i + 1
			if i <= n then return o._cells[i] end
		end
	end,
	__len = function(o)
		return #o._cells
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "cells:{[")
		for i,c in ipairs(o._cells) do
			table.insert(t, "{id:")	table.insert(t, c:getId())
			if i < #o._cells then
				table.insert(t, "},")
			else
				table.insert(t, "}")
			end
		end
		table.insert(t, "]}")
		return table.concat(t)
	end
}
--[[////////////////////////////////////
//			Object: Function Index				//
////////////////////////////////////--]]
local object_idx = {

}
--[[////////////////////////////////////
//			Class: Table									//
////////////////////////////////////--]]
local Town = {}
	Town.MOORE = function(board, point)
		local town = {}

		local function helper(i, b, e)
				for j = b,e do
					if i == #point then
						local p = point:diffCopy(i, j)
						print(p)
						if p ~= point then
							table.insert(town, board:getCell(p))
						end
					else
						helper(i+1, point[i]-1, point[i]+1)
					end
				end
			end
			helper(1, point[1]-1, point[1]+1)
		return town
	end
	Town.VONNEUMANN = function(board, point)
		local town = {}
		for i,v in point() do
			table.insert(town, board:getCell(point:diffCopy(i, v-1)))
			table.insert(town, board:getCell(point:diffCopy(i, v+1)))
		end

		return town
	end
	Town.new = function(town_type, board, point)
		local self = setmetatable({}, object_meta)
		
		self._cells = town_type(board, point)
		self._town_type = town_type

		return self
	end
--[[////////////////////////////////////
//			Class: Metatable							//
////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end,
	__newindex = function(class, k, v)
		class._builders[k] = v
	end
}

object_meta.__index = object_idx
setmetatable(Town, class_meta)

return Town






