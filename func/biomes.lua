biomes = {}

function biomes.getBiome(biome)

	if biome == "plains" then
		ret = {
			caveRarity = 1000,
			lakeRarity = 10000,
			yInt = 0.01,
			xInt = 2,
			biome1Min = 120,
			biome1Max = 125,
			biome2Min = 3,
			biome2Max = 4,
			treeFrequincy = 40
		}
	elseif biome == "hills" then
		ret = {
			yInt = 0.5,
			xInt = 1,
			biome1Min = 40,
			biome1Max = 53,
			biome2Min = 3,
			biome2Max = 5,
			treeFrequincy = 20
		}
	elseif biome == "old" then
		ret = {
			caveRarity = 7500,
			lakeRarity = 5000,
			yInt = 0.5,
			xInt = 1,
			biome1Min = 40,
			biome1Max = 53,
			biome2Min = 4,
			biome2Max = 4,
			treeFrequincy = 20
		}
	elseif biome == "extreme" then
		ret = {
			yInt = 1,
			xInt = 1,
			biome1Min = 40,
			biome1Max = 200,
			biome2Min = 4,
			biome2Max = 7,
			treeFrequincy = 20
		}
	end

	return ret

end

return biomes
