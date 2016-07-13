local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_meta = {
	
}
local object_idx = {
	save = function(self)
		
	end
}
local Session = {}
	Session.new = function(name)
		local self = setmetatable({}, object_meta)

		self._name = name
		self._directory = nil
		self._board = nil			-- Might change later to something more abstract like board_manager
		self._undo_stack = {}
		self._redo_stack = {}

		return self
	end
	Session.loadSession = function(name)

	end
	Session.EXTENSION = ".cax"

object_meta.__index = object_idx
setmetatable(Session, class_meta)

return Session





