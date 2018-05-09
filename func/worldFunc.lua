worldFunc = {}

local vx = 0
local world = {}

function worldFunc.initWorld(xMin, xMax)
	for x = xMin, xMax do
		world[x] = {}
	end

	for x = xMin, xMax do
		for y = 0, 1024 do

				world[x][y] = {block=blocks.air, waterLevel=0, blockData={}}
				--print("set block X:" .. x .. ", Y" .. y .. " to:" .. "air")

		end
	end
end

function worldFunc.getBlock(x, y)

	local returnValue

	--rounding
	x = math.floor(x)
	y = math.floor(y)

	--get block
	if world then
		if world[x] then
			if world[x][y] then
				returnValue = world[x][y]["block"]
			end
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

	return returnValue
end
