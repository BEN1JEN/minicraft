worldFunc = {}

local vx = 0

function worldFunc.getBlock(x, y)
		local returnValue = blocks.air
		--get block
		if world[x] then
			if world[x][y] then
				returnValue = world[x][y]
			end
		end
		return returnValue
end


function worldFunc.setblock(x, y, id)
		--set block
		world[x][y][id] = id
end
