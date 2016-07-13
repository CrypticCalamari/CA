local class_mt = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_mt = {
	
}
local object_idx = {
	save = function(self)
		
	end
}
local Session = {
	new = function(name)
		local self = {}

		self._name = name
		self._directory = nil
		self._board = nil			-- Might change later to something more abstract like board_manager
		self._undo_stack = {}
		self._redo_stack = {}

		setmetatable(self, object_mt)
		return self
	end,
	load = function(name)

	end,
	EXTENSION = ".cax"
}
object.__index = object_idx
setmetatable(Session, class_mt)
return Session





