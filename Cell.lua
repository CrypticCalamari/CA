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
		local fiber = "{\n"

		fiber = fiber.."\t"..object._address..", "
		fiber = fiber.."id:"..object._id..", "
		fiber = fiber.."x:"..object._x..", "
		fiber = fiber.."y:"..object._y..", "
		fiber = fiber.."region:"..object._region._address..",\n"
		fiber = fiber.."\told_state:"..tostring(object._old_state)..", "
		fiber = fiber.."state:"..tostring(object._state)..", "
		fiber = fiber.."new_state:"..tostring(object._new_state)..",\n"
		fiber = fiber.."\ttown:\n\t[\n"

		if object._town then
			for i,c in ipairs(object._town) do
				fiber = fiber..c._address

				if i < #object._town then
					fiber = fiber..", "
				end
			end
		end

		fiber = fiber.."]}"

		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end,
	getX = function(self) return self._x end,
	getY = function(self) return self._y end,
	getPos = function(self) return self._x, self._y end,
	getRegion = function(self) return self._region end,
	getTown = function(self) return self._town end,
	getOldState = function(self) return self._old_state end,
	getState = function(self) return self._state end,
	getNewState = function(self) return self._new_state end,

	setRegion = function(self, region) self._region = region end,
	setTown = function(self, town) self._town = town end,
	setOldState = function(self, old_state) self._old_state = old_state end,
	setState = function(self, state) self._state = state end,
	setNewState = function(self, new_state) self._new_state = new_state end,

	updateState = function(self)
		self._old_state = self._state
		self._state = self._new_state
	end
}
local Cell = {
	new = function(id, x, y, region, state)
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
}
object_mt.__index = object_idx
setmetatable(Cell, class_mt)
return Cell




-- TODO: abstract away the dimension variables to allow variable number of dimensions
