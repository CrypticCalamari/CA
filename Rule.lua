local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_mt = {
	__eq = function(left, right)
		return left._id == right._id		-- Placeholder
	end,
	__tostring = function(object)
		local fiber = "{"

		fiber = fiber.."address:"..object._address..", "
		fiber = fiber.."id:"..object._id..", "
		fiber = fiber.."town_key:"..object._town_key..", "
		fiber = fiber.."new_state:"..object._new_string.."}"

		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end,
	getTownKey = function(self) return self._town_key end,
	getNewState = function(self) return self._new_state end
}
local Rule = {
	new = function(id, town_key, new_state)
		local self = {}

		self._address = tostring(self)
		self._id = id
		self._town_key = town_key
		self._new_state = new_state
	
		setmetatable(self, object_mt)
		return self
	end
}
object_mt.__index = object_idx
setmetatable(Rule, class_mt)
return Rule





