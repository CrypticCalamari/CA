local TownKeyGenSum = {}

TownKeyGenSum.getTownKey = function(cell)
	local sum = 0

	for k,v in pairs(cell:getTown()) do
		sum = sum + v:getState():getValue()
	end

	return sum
end

return TownKeyGenSum
