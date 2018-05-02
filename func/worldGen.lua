worldGen = {}

local yDist1 = 122
local yDist2 = 0
local yInc1 = 0
local yInc2 = 0
local offSet = 64
local lastXMin = 0
local lastXMax = lastXMin + offSet
local buffer = -1

function worldGen.updateWorld()

	for i, v in pairs(biomes) do
		if math.random(1, v.rarity) == 1 then
			biome = v
		end
	end

	while world[math.floor((player.x + 52 + buffer) + 0.5 )] == nil or world[math.floor((player.x + 52 + buffer) + 0.5 )][5] == nil do
		-- print (player.x+52+buffer)
		world = worldGen.genarate(biome, lastXMin, lastXMax)
		-- print(lastXMin, lastXMax) --debug code
		lastXMax = lastXMax + offSet
		lastXMin = lastXMin + offSet
	end

	--if lastBiome ~= biome then
	--	yDist1 = math.random(biome.biome1Min, biome.biome1Max)
	--	yDist2 = math.random(biome.biome2Min, biome.biome2Max)
	--end
	local lastBiome = biome

end

function worldGen.cave(x, y, dir, size, block)

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

function worldGen.circle(x, y, cirSize, block)

	for c = 1, cirSize * 2 * math.pi do
		for r = 1, cirSize do
			--print("X: " .. math.floor( x + math.sin(c) * r ) * r .. ", Y: " .. math.floor( y + math.cos(c) * r ) .. ", R:" .. r .. ", C: " .. c) --debug code
			--print(world[0]) --debug code
			worldFunc.setBlock(math.floor( x + math.sin(c) * r ), math.floor( y + math.sin(c) * r ), block )
		end
	end

	return world

end

function worldGen.tree(type, dirtY, x)

	local yOffset
	if type == "oak" then
		if math.random(1, 2) == 1 then
			for i = 1, math.random(4, 6) do
				worldFunc.setBlock(x, dirtY + 1 + i, "oakLog")
				yOffset = i + 2
			end
			worldFunc.setBlock(x, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x, dirtY + yOffset + 2, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x - 2, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x + 2, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x - 2, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x + 2, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset + 2, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset + 2, "oakLeaves")
		else
			for i = 1, math.random(5, 8) do
				worldFunc.setBlock(x, dirtY + 1 + i, "oakLog")
				yOffset = i + 2
			end
			worldFunc.setBlock(x, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset + 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x - 2, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x + 2, dirtY + yOffset, "oakLeaves")
			worldFunc.setBlock(x - 2, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x + 2, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset - 1, "oakLeaves")
			worldFunc.setBlock(x - 1, dirtY + yOffset - 2, "oakLeaves")
			worldFunc.setBlock(x + 1, dirtY + yOffset - 2, "oakLeaves")
		end
	end

end

function worldGen.genarate(biome, xMin, xMax)

		-- print(biome.name) --debug code

	for x = xMin, xMax do
		world[x] = {}
	end

	for x = xMin, xMax do
		for y = 0, 1024 do

				world[x][y] = {block=blocks.air, waterLevel=0, blockData={}}
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
				worldFunc.setBlock(x, y, biome.layer1Block)
				tmpY = y
		end

		--Dirt layer
		for y = tmpY, tmpY + yDist2 do
				worldFunc.setBlock(x, y, biome.layer2Block)
				tmpY = y
		end

		worldFunc.setBlock(x, tmpY + 1, biome.topBlock)
		if math.random(1, biome.treeRarity) == 1 and x > xMin + 2 and x < xMax - 2 then
			worldGen.tree(biome.treeType, tmpY, x)
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

	-- generate oceans
	for x = xMin, xMax do
		for y = 0, 100 do

				if worldFunc.getBlock(x, y) == blocks.air then worldFunc.setBlock( x, y, "water" ) end
				--print("set block X:" .. x .. ", Y" .. y .. " to:" .. "air")

		end
	end

	-- cave and lake generation
	for x = xMin, xMax do
		for y = 1, 750 do

			if math.random(1, biome.caveRarity) == 1 and worldFunc.getBlock(x, y) == blocks.stone then
				world = worldGen.cave(x, y, math.random(1, 360), math.random(150,2000), "air")
			end

			if math.random(1, biome.lakeRarity) == 1 and worldFunc.getBlock(x, y).lakeAble then
				world = worldGen.cave(x, y, math.random(1, 360), math.random(150,2000), "water")
			end

		end
	end

	-- generate ores
	for x = xMin, xMax do
		for y = 2, 128 do
			if math.random(1, 4) == 1 and worldFunc.getBlock(x, y) == blocks.stone then

				if math.random(1, 2) == 1 then
					worldFunc.setBlock( x, y, "coalOre" )
				end
				if math.random(1, 6) == 1 then
					worldFunc.setBlock( x, y, "copperOre" )
				end
				if math.random(1, 8) == 1 and y < 30 then
					worldFunc.setBlock( x, y, "ironOre" )
				end
				if math.random(1, 20) == 1 and y < 15 then
					worldFunc.setBlock( x, y, "goldOre" )
				end
				if math.random(1, 50) == 1 and y < 10 then
					worldFunc.setBlock( x, y, "diamondOre" )
				end
			end
		end
	end


	--print("id:" .. world[x][y]["id"] .. ", blockName:" .. world[x][y]["name"]) --debug code
	--print("prev:" .. yDist1, yDist2, yInc1, yInc2, xMin, xMax) --debug code
	return world

end

return worldGen
