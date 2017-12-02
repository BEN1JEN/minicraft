biomeDeclaration = {}

function biomeDeclaration.declareBiomes()

	biomeDeclaration.declareBiome("plains", 6000, 7500, 10000, 0.01, 2, 120, 125, 3, 4, 40)
	biomeDeclaration.declareBiome("hills", 12000, 100000, 8000, 0.5, 1, 115, 130, 3, 5, 20)
	biomeDeclaration.declareBiome("old", 6000000, 75000, 5000, 0.5, 1, 40, 53, 4, 4, 10)
	biomeDeclaration.declareBiome("extreme", 60000, 10000, 10000, 2, 0.5, 64, 160, 4, 7, 25)
	biomeDeclaration.declareBiome("ocean", 9000, 100000, 1000000, 0.002, 5, 80, 96, 2, 4, 1000000000)

	return biomes

end

function biomeDeclaration.declareBiome(name, rarity, caveRarity, lakeRarity, yInt, xInt, biome1Min, biome1Max, biome2Min, biome2Max, treeRarity)
	biomes[name] = { name = name, rarity = rarity, caveRarity = caveRarity, lakeRarity = lakeRarity, yInt = yInt, xInt = xInt, biome1Min = biome1Min, biome1Max = biome1Max, biome2Min = biome2Min, biome2Max = biome2Max, treeRarity = treeRarity}
end

return biomeDeclaration
