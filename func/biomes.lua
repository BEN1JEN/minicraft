biomes = {}

function biomes.getBiome(biome)

	if biome == "plains" then
		plains = {
			rarity = 1000,
			caveRarity = 750,
			lakeRarity = 10000,
			yInt = 0.01,
			xInt = 2,
			biome1Min = 120,
			biome1Max = 125,
			biome2Min = 3,
			biome2Max = 4,
			treeRarity = 40
		}
	elseif biome == "hills" then
		hills = {
			rarity = 2000,
			caveRarity = 10000,
			lakeRarity = 8000,
			yInt = 0.5,
			xInt = 1,
			biome1Min = 115,
			biome1Max = 130,
			biome2Min = 3,
			biome2Max = 5,
			treeRarity = 20
		}
	elseif biome == "old" then
		old = {
			rarity = 1000000,
			caveRarity = 7500,
			lakeRarity = 5000,
			yInt = 0.5,
			xInt = 1,
			biome1Min = 40,
			biome1Max = 53,
			biome2Min = 4,
			biome2Max = 4,
			treeRarity = 20
		}
	elseif biome == "extreme" then
		extreme = {
			rarity = 10000,
			caveRarity = 1000,
			lakeRarity = 10000,
			yInt = 2,
			xInt = 0.5,
			biome1Min = 64,
			biome1Max = 160,
			biome2Min = 4,
			biome2Max = 7,
			treeRarity = 20
		}
	elseif biome == "ocean" then
		ocean = {
			rarity = 1500,
			caveRarity = 1000,
			lakeRarity = 10000,
			yInt = 0.02,
			xInt = 2.5,
			biome1Min = 80,
			biome1Max = 96,
			biome2Min = 2,
			biome2Max = 4,
			treeRarity = 1000000
		}
	end

	biomeDeclaration.declareBiome()
	biomeDeclaration.declareBiome("extreme", 10000, 1000, 10000, 2, 0.5, 64, 160, 4, 7, 20)
	biomeDeclaration.declareBiome("ocean", 1500, 1000, 10000, 0.02, 2.5, 80, 96, 2, 4, 1000000)

	return ret

end

function biomeDeclaration.declareBiome(name, rarity, caveRarity, lakeRarity, yInt, xInt, biome1Min, biome1Max, biome2Min, biome2Max, treeRarity)
	biomes[name] = { name = name, rarity = rarity, caveRarity = caveRarity, lakeRarity = lakeRarity, yInt = yInt, xInt = xInt, biome1Min = biome1Min, biome1Max = biome1Max, biome2Min = biome2Max, treeRarity = treeRarity}
end

return biomes
