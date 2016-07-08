--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local Point = {}
setmetatable(Point, class_meta)
--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local object_idx = {
	copy = function(self)
		return Point(unpack(self._point))
	end,
	diff = function(self, i, v)
		p = {unpack(self._point)}
		p[i] = v
		return Point(unpack(p))
	end,
	offset = function(self, i, o)
		p = {unpack(self._point)}
		p[i] = p[i] + o
		return Point(unpack(p))
	end,
	ipairs = function(self)
		local i = 0
		local n = #self._point
		return function(self)
			i = i + 1
			if i <= n then return i,self._point[i] end
		end
	end
}
local object_meta = {
	__index = function(o, i)
		return object_idx[i] or o._point[i]
	end,
	__len = function(o)
		return #o._point
	end,
	__ne = function(left, right)
		for i,v in ipairs(left._point) do
			if v ~= right._point[i] then
				return true
			end
		end
		return false
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
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
	Point.new = function(...)
		local self = setmetatable({}, object_meta)

		self._point = {...}

		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
return Point





