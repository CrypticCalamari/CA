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
		local fiber = "{"

		fiber = fiber.."address:"..object._address..", "
		fiber = fiber.."id:"..object._id..", "
	-----------------------------
		fiber = fiber.."region:["
		for i,cell in ipairs(object._region) do
			fiber = fiber..cell..", "
		end
		if string.sub(fiber, -2) == ", " then
			fiber = string.sub(fiber, 1, #fiber-2)
		end
	-----------------------------
		fiber = fiber.."], state_rule:["

		for i,state_rule in ipairs(object._state_rule) do
			fiber = fiber..state_rule..", "			-- TODO: overload __tostring in StateRule
		end
		if string.sub(fiber, -2) == ", " then
			fiber = string.sub(fiber, 1, #fiber-2)
		end
	-----------------------------
		fiber = fiber.."], state_town_key_gen:["

		for i,state_town_key_gen in ipairs(object._state_town_key_gen) do
			fiber = fiber..state_town_key_gen..", "
		end
		if string.sub(fiber, -2) == ", " then
			fiber = string.sub(fiber, 1, #fiber-2)
		end
	-----------------------------
		fiber = fiber.."]}"

		return fiber
	end
}
local object_idx = {
	getId = function(self) return self._id end
	contains = function(self, cell)
		if self._region[cell:getId()] then
			return true
		end
		return false
	end,
	addCell = function(self, cell)
		self._region[cell:getId()] = cell
	end,
	removeCell = function(self, cell)
		self._region[cell:getId()] = nil
	end,
	addStateRule = function(self, state_id, state_rule)
		self._state_rule[state_id] = state_rule
	end,
	removeStateRule = function(self, state_id)
		self._state_rule[state_id] = nil
	end,
	addStateTownKeyGen = function(self, state_id, town_key_gen)
		self._state_town_key_gen[state_id] = town_key_gen
	end,
	removeStateTownKeyGen = function(self, state_id)
		self._state_town_key_gen[state_id] = nil
	end,
	updateNewState = function(self)
		for k, cell in pairs(self._region) do
			cell_state_id = cell:getState():getId()
			town_key = self._state_town_key_gen[cell_state_id].getTownKey(cell)
			new_state = self._state_rule[cell_state_id]:getNewState(town_key)

			cell:setNewState(new_state or cell:getState())
		end
	end
}
local Region = {
	new = function(id)
		local self = {}

		self._address = tostring(self)
		self._id = id
		self._region = {}
		self._state_rule = {}
		self._state_town_key_gen = {}

		setmetatable(self, object_mt)
		return self
	end
}
object_mt.__index = object_idx
setmetatable(Region, class_mt)
return Region





