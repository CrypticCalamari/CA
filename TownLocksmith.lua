local class_meta = {
	__call = function(class, lock_type, town)
		return class.getTownKey(lock_type, town)
	end
}
local TownLocksmith = {}
	TownLocksmith.SUM = "sum"
	TownLocksmith.STATECOUNT = "stateCount"
	TownLocksmith._locks = {}
	TownLocksmith.sum = function(town)
		local sum = 0
		for call in town() do
			sum = sum + cell:getState():getValue()
		end
		return sum
	end
	TownLocksmith.stateCount = function(town)

	end
	TownLocksmith.getTownKey = function(lock_type, town)
		return TownLocksmith._locks[ lock_type ](town)
	end
	TownLocksmith._locks[ TownLocksmith.SUM ] = TownLocksmith.sum
	TownLocksmith._locks[ TownLocksmith.STATECOUNT ] = TownLocksmith.sum
return TownLocksmith







