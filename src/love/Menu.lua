

local Menu = {}
	Menu.new = function()
		local self = Menu.singleton or setmetatable({}, object_meta)

		self._menuitems = {}

		if not Menu.singleton then Menu.singleton = self end
		return self
	end

return Menu
