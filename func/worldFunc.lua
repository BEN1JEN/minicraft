worldFunc = {}

local vx = 0

function worldFunc.getBlock(x, y)
		--get block
		return world[x][y]
end


function worldFunc.setblock(x, y, id)
		--set block
		world[x][y][id] = id
end
