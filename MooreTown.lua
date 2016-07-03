local MooreTown = {}

MooreTown.getTown = function(board, border_cell, x, y, r)
	local town = {}

	for i = x-r, x+r do
		for j = y-r, y+r do
			if not (i == x and j == y) then
				table.insert(town, board:getCell(i, j) or border_cell)
			end
		end
	end

	return town
end

return MooreTown





