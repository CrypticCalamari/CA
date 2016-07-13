--[[////////////////////////////////////
//			Class: Metatable							//
////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local Point = {}
setmetatable(Point, class_meta)
--[[////////////////////////////////////
//			Object: Function Index				//
////////////////////////////////////--]]
local object_idx = {
	copy = function(self)
		return Point(unpack(self._point))
	end,
	diffCopy = function(self, i, v)
		p = {unpack(self._point)}
		p[i] = v
		return Point(unpack(p))
	end,
	--[[ NOTE:	temporarily commenting out these two functions until there is a 
					use case for them. Previous use case subsumed by __newindex
	offset = function(self, i, o)
		p = {unpack(self._point)}
		p[i] = p[i] + o
		return Point(unpack(p))
	end,]]
	push = function(self, new_dim)
		table.insert(self._point, new_dim)
	end,
	pushFront = function(self, new_dim)
		table.insert(self._point, 1, new_dim)
	end,
	pop = function(self)
		return table.remove(self._point)
	end
}
--[[////////////////////////////////////
//			Object: Metatable							//
////////////////////////////////////--]]
local object_meta = {
	__call = function(o)
		local i = 0
		local n = #o._point
		return function()
			i = i + 1
			if i <= n then return i,o._point[i] end
		end
	end,
	__index = function(o, i)
		return object_idx[i] or o._point[i]
	end,
	__newindex = function(o, k, v)
		if k > 0 and k <= #o._point then
			o._point[k] = v
		else
			error("Don't use Point's newindex like that. TODO: Handle this better.")
		end
	end,
	__len = function(o)
		return #o._point
	end,
	__ne = function(left, right)
		if #left._point ~= #right._point then
			return true
		end
		for i,v in ipairs(left._point) do
			if v ~= right._point[i] then
				return true
			end
		end
		return false
	end,
	__eq = function(left, right)
		if #left._point ~= #right._point then
			return false
		end
		for i,v in ipairs(left._point) do
			if v ~= right._point[i] then
				return false
			end
		end
		return true
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{")

		for i,v in ipairs(o._point) do
			table.insert(t, tostring(v))

			if i < #o._point then
				table.insert(t, ",")
			end
		end

		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[////////////////////////////////////
//			Class: Table									//
////////////////////////////////////--]]
	Point.new = function(...)
		local self = {}

		self._point = {...}

		setmetatable(self, object_meta)
		return self
	end

return Point





