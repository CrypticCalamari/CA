local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_mt = {
	__eq = function(left, right)
		return left._id == right._id
	end,
	__tostring = function(object)
		fiber = "{"

		fiber = fiber..object._address..", "
		fiber = fiber.."id:"..object._id..", "
		fiber = fiber.."value:"..object._value.."}"

		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end,
	getValue = function(self) return self._value end
}
local State = {
	new = function(id, value)
		local self = {}
	
		self._address = tostring(self)
		self._id = id
		self._value = value
	
		setmetatable(self, object_mt)

		return self
	end
}
object_mt.__index = object_idx
setmetatable(State, class_mt)
return State





