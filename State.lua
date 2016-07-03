local class_mt = {}
local object_mt = {}
local object_idx = {}
local State = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return left._id == right._id
end
function object_mt.__tostring(object)
	the_string = "{"

	the_string = the_string..object._address..", "
	the_string = the_string.."id:"..object._id..", "
	the_string = the_string.."value:"..object._value.."}"

	return the_string
end
function object_idx:getId() return self._id end
function object_idx:getValue() return self._value end

function State.new(id, value)
	local self = {}
	
	self._address = tostring(self)
	self._id = id
	self._value = value
	
	setmetatable(self, object_mt)

	return self
end

return State





