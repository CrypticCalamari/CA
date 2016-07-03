local class_mt = {}
local object_mt = {}
local object_idx = {}
local Rule = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return left._id == right._id		-- Placeholder
end
function object_mt.__tostring(object)
	local the_string = "{"

	the_string = the_string.."address:"..object._address..", "
	the_string = the_string.."id:"..object._id..", "
	the_String = the_string.."town_key:"..object._town_key..", "
	the_string = the_string.."new_state:"..object._new_string.."}"

	return the_string
end

function object_idx:getId() return self._id end
function object_idx:getTownKey() return self._town_key end
function object_idx:getNewState() return self._new_state end

function Rule.new(id, town_key, new_state)
	local self = {}

	self._address = tostring(self)
	self._id = id
	self._town_key = town_key
	self._new_state = new_state
	
	setmetatable(self, object_mt)

	return self
end

return Rule





