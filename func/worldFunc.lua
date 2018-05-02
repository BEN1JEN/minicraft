worldFunc = {}

local vx = 0

function worldFunc.getBlock(x, y)

	local returnValue

	--rounding
	x = math.floor(x)
	y = math.floor(y)

	--get block

	if world[x] then
		if world[x][y] then
			returnValue = world[x][y]["block"]
		end
	end
	if not( returnValue ) then
		--print("warning: block at " .. x .. ", " .. y .. " does not exist.")
		returnValue = blocks.air
	end
	return returnValue
end


function worldFunc.setBlock(x, y, block)

	local returnValue = false

	--set block
	if world[x] then
		if world[x][y] then
			world[x][y]["block"] = blocks[block]
			returnValue = true
		end
	end

	if not( returnValue ) then
		--print("warning: block at " .. x .. ", " .. y .. " does not exist.")
	end

end
