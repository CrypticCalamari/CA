local TownLock = {}
	TownLock.SUM = function(town)
		local sum = 0
		for cell in town() do
			sum = sum + cell:getState():getValue()
		end
		return sum
	end
	TownLock.STATECOUNT = function(town)

	end
return TownLock







