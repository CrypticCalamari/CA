local class_mt = {}
local object_mt = {}
local object_idx = {}
local Class = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return false
end
function object_idx:getId()
	return self._id
end

function Class.new(id)
	local self = setmetatable({}, object_mt)

	self._id = id

	return self
end

return Class
