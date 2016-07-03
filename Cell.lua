local class_mt = {}
local object_mt = {}
local object_idx = {}
local Cell = setmetatable({}, class_mt)

object_mt.__index = object_idx

function class_mt.__call(class, ...)
	return class.new(...)
end
function object_mt.__eq(left, right)
	return left._id == right._id
end
function object_mt.__tostring(object)
	local the_string = "{\n"
	
	the_string = the_string.."\t"..object._address..", "
	the_string = the_string.."id:"..object._id..", "
	the_string = the_string.."x:"..object._x..", "
	the_string = the_string.."y:"..object._y..", "
	the_string = the_string.."region:"..object._region._address..",\n"
	the_string = the_string.."\told_state:"..tostring(object._old_state)..", "
	the_string = the_string.."state:"..tostring(object._state)..", "
	the_string = the_string.."new_state:"..tostring(object._new_state)..",\n"
	the_string = the_string.."\ttown:\n\t[\n"

	if object._town then
		for i,c in ipairs(object._town) do
			the_string = the_string..c._address

			if i < #object._town then
				the_string = the_string..", "
			end
		end
	end

	the_string = the_string.."]}"

	return the_string
end
function object_idx:getId() return self._id end
function object_idx:getX() return self._x end
function object_idx:getY() return self._y end
function object_idx:getPos() return self._x, self._y end
function object_idx:getRegion() return self._region end
function object_idx:getTown() return self._town end
function object_idx:getOldState() return self._old_state end
function object_idx:getState() return self._state end
function object_idx:getNewState() return self._new_state end

function object_idx:setRegion(region) self._region = region end
function object_idx:setTown(town) self._town = town end
function object_idx:setOldState(old_state) self._old_state = old_state end
function object_idx:setState(state) self._state = state end
function object_idx:setNewState(new_state) self._new_state = new_state end

function object_idx:updateState()
	self._old_state = self._state
	self._state = self._new_state
end

function Cell.new(id, x, y, region, state)
	local self = {}

	self._address = tostring(self)
	self._id = id
	self._x = x
	self._y = y
	self._region = region
	self._state = state
	
	setmetatable(self, object_mt)

	return self
end

return Cell

-- TODO: abstract away the dimension variables to allow variable number of dimensions



