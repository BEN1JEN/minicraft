worldGen = {}

local yDist1 = 122
local yDist2 = 0
local yInc1 = 0
local yInc2 = 0
local offSet = 50
local lastXMin = 0
local lastXMax = lastXMin + offSet
local buffer = -1

function worldGen.updateWorld(world, biome, blocks, playerX, playerY)
	while world[math.floor((playerX + 52 + buffer) + 0.5 )] == nil or world[math.floor((playerX + 52 + buffer) + 0.5 )][5] == nil do
		-- print (playerX+52+buffer)
		world = worldGen.genarate(world, biome, blocks, lastXMin, lastXMax)
		-- print(lastXMin, lastXMax) --debug code
		lastXMax = lastXMax + offSet
		lastXMin = lastXMin + offSet
	end

	if lastBiome == biome then
		yDist1 = math.random(biome.biome1Min, biome.biome1Max)
		yDist2 = math.random(biome.biome2Min, biome.biome2Max)
	end
	local lastBiome = biome
	return world
end

function worldGen.cave(x, y, dir, size, block, blocks, world)

	local cirGoal = 5
	local cirSize = 5
	local yVer = 2.5
	local dirInc = 0

	for i=1, math.random(size - 10, size + 10) do

		dir = dir + dirInc
		dirInc = dirInc + math.random(-1, 1)

		world = worldGen.circle(x, y, cirSize, block, blocks, world)

		 x = x + math.sin(dir)
		 y = y + math.cos(dir)

		 if cirSize == cirGoal then

			 cirGoal = math.random(0, 10)

			 if cirSize == 0 then
				 break
			 end

		 else

			 local tmp = 0
			 if cirSize > cirGoal then
				 tmp = -1
			 else
				 tmp = 1
			 end

			 cirSize = math.random(-1, 2) * tmp

		 end

	end

	return world

end

function worldGen.circle(x, y, cirSize, block, blocks, world)

	for c = 1, cirSize * 2 * math.pi do
		for r = 1, cirSize do
			--print("X: " .. math.floor( x + math.sin(c) * r ) * r .. ", Y: " .. math.floor( y + math.cos(c) * r ) .. ", R:" .. r .. ", C: " .. c) --debug code
			--print(world[0]) --debug code
			if world[ math.floor( x + math.sin(c) * r ) ] ~= nil then if world[ math.floor( x + math.sin(c) * r ) ][ math.floor( y + math.sin(c) * r ) ] ~= nil then
				world[ math.floor( x + math.sin(c) * r ) ][ math.floor( y + math.sin(c) * r ) ] = { name = block, ID = blockFunc.getID(block, blocks) }
			end end
		end
	end

	return world

end

function worldGen.worldInit()



end

function worldGen.genarate(world, biome, blocks, xMin, xMax)

	for x = xMin, xMax do
		world[x] = {}
	end

	for x = xMin, xMax do
		for y = 0, 1000 do

				world[x][y] = blocks.air
				--print("set block X:" .. x .. ", Y" .. y .. " to:" .. "air")

		end
	end

	--print("next:" .. yDist1, yDist2, yInc1, yInc2, xMin, xMax.. "\n") --debug code
	for x = xMin, xMax do

		if x == xMin then

		end

		local tmpY = 0

		--Stone layer
		for y = 0, yDist1 do
				world[x][y] = blocks.stone
				tmpY = y
		end

		--Dirt layer
		for y = tmpY, tmpY + yDist2 do
				world[x][y] = blocks.dirt
				tmpY = y
		end

		world[x][tmpY + 1] = blocks.grass
		if math.random(1, biome.treeFrequincy) == 1 and x > xMin + 2 and x < xMax - 2 then
			local a
			for i = 1, math.random(4, 7) do
				world[x][tmpY + 1 + i] = blocks.oakLog
				a = i + 2
			end
			world[x][tmpY + a] = blocks.oakLeaves
			world[x][tmpY + a + 1] = blocks.oakLeaves
			world[x][tmpY + a + 2] = blocks.oakLeaves
			world[x - 1][tmpY + a - 1] = blocks.oakLeaves
			world[x - 2][tmpY + a - 1] = blocks.oakLeaves
			world[x + 1][tmpY + a - 1] = blocks.oakLeaves
			world[x + 2][tmpY + a - 1] = blocks.oakLeaves
			world[x - 1][tmpY + a] = blocks.oakLeaves
			world[x - 2][tmpY + a] = blocks.oakLeaves
			world[x + 1][tmpY + a] = blocks.oakLeaves
			world[x + 2][tmpY + a] = blocks.oakLeaves
			world[x - 1][tmpY + a + 1] = blocks.oakLeaves
			world[x - 1][tmpY + a + 2] = blocks.oakLeaves
			world[x + 1][tmpY + a + 1] = blocks.oakLeaves
			world[x + 1][tmpY + a + 2] = blocks.oakLeaves
		end

		--Stone layer
		if ( not ( yDist1 > biome.biome1Max ) ) and ( math.random(0, 1) == 0 or yDist1 < biome.biome1Min ) then
			yInc1 =  yInc1 + biome.yInt
		else
			yInc1 = yInc1 - biome.yInt
		end

		local maxYInc1 = math.abs(biome.biome1Max - biome.biome1Min) / 5
		if yInc1 > maxYInc1 then
			yInc1 = maxYInc1
		elseif yInc1 < -maxYInc1 then
			yInc1 = -maxYInc1
		end

		yDist1 = yDist1 + yInc1


		--Dirt layer
		if ( not ( yDist2 > biome.biome2Max ) ) and ( math.random(0, 1) == 0 or yDist2 < biome.biome2Min ) then
			yInc2 =  yInc2 + biome.yInt
		else
			yInc2 = yInc2 - biome.yInt
		end

		local maxYInc2 = math.abs(biome.biome2Max - biome.biome2Min) / 5
		if yInc2 > maxYInc2 then
			yInc2 = maxYInc2
		elseif yInc2 < -maxYInc2 then
			yInc2 = -maxYInc2
		end

		for x = xMin, xMax do
					world[x][0] = blocks.bedrock
		end

		yDist2 = yDist2 + yInc2


		--yDist2 = math.random(biome.biome2Min, biome.biome2Max)

	end

 --[[


	for x = -1000, 1000 do
		for y = 1, 750 do

			if math.random(1, biome.caveRarity) == 1 and world[x][y]["ID"] == 2 then
				world = worldGen.cave(x, y, math.random(1, 360), math.random(150,2000), "air", blocks, world)
			end

			if math.random(1, biome.lakeRarity) == 1 and world[x][y]["ID"] == 2 then
				world = worldGen.cave(x, y, math.random(1, 360), math.random(150,2000), "water", blocks, world)
			end

		end
	end

	]]

	-- generate ores
	--[[ --NOPE
	for x = xMin, xMax do
		for y = 2, 128 do
			if math.random(1, 4) == 1 and world[x][y]["ID"] == 2 then

				if math.random(1, 2) == 1 then
					world[x][y] = { name = "coalOre", ID = 10 }
				end
				if math.random(1, 6) == 1 then
					world[x][y] = { name = "copperOre", ID = 11 }
				end
				if math.random(1, 8) == 1 and y < 30 then
					world[x][y] = { name = "ironOre", ID = 12 }
				end
				if math.random(1, 20) == 1 and y < 15 then
					world[x][y] = { name = "goldOre", ID = 13 }
				end
				if math.random(1, 50) == 1 and y < 10 then
					world[x][y] = { name = "diamondOre", ID = 14 }
				end
			end
		end
	end

	]]

--[[
	for x = xMin, xMax do
		for y = 0, 64 do

				print(x,y)
				if world[x][y]["name"] == "air" then world[x][y] = blocks.water end
				--print("set block X:" .. x .. ", Y" .. y .. " to:" .. "air")

		end
	end
	]]

	--print("id:" .. world[x][y]["id"] .. ", blockName:" .. world[x][y]["name"]) --debug code
	--print("prev:" .. yDist1, yDist2, yInc1, yInc2, xMin, xMax) --debug code
	return world

end

return worldGen
