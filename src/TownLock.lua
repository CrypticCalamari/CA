--[[//////////////////////////////////////////////////////////
//	TODO:																										//
//			*	Finish the other TownLock key generation methods.	//
//			* Currently this class is very simple and will			//
//				probably remain that way with the addition of			//
//				these new methods.																//
////////////////////////////////////////////////////////////]]


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







