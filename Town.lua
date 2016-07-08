--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local object_meta = {
	__call = function(o)
		local i = 0
		local n = #o._cells
		return function(o)
			i = i + 1
			if i <= n then return o._cells[i] end
		end
	end
}
--[[/////////////////////////////////////
//			Object: Function Index			//
/////////////////////////////////////--]]
local object_idx = {

}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
local Town = {}
	Town.MOORE = "Moore"
	Town.VONNEUMANN = "VonNeumann"
	Town._builders = {}
	Town._builders[ Town.MOORE ]  = function(board, point)
		local town = {}

		local nestFor = function(i, b, e)
				for j = b,e do
					if i == #point then
						local p = point:diff(i, j)
						if p ~= point then
							table.insert(town, board:getCell(p))
						end
					else
						nestFor(i+1, point[i]-1, point[i]+1)
					end
				end
			end
			nestFor(1, point[1]-1, point[1]+1)

		return town
	end
	Town[ Town.VONNEUMANN ] = function(board, point)
		local town = {}

		for i,v in point:ipairs() do
			table.insert(town, board:getCell(point:diff(i, v-1)))
			table.insert(town, board:getCell(point:diff(i, v+1)))
		end

		return town
	end
	Town.new = function(town_type, board, point)
		local self = setmetatable({}, object_meta)

		self._cells = Town._builders[ town_type ](board, point)
		self._town_type = town_type

		return self
	end
--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end,
	__newindex = function(class, k, v)
		class._builders[k] = v
	end
}
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
object_meta.__index = object_idx
setmetatable(Town, class_meta)
return Town
-- CHANGED: Moved the radius parameter to the TownKeyGen function





