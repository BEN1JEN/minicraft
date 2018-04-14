biomeDeclaration = {}

function biomeDeclaration.declareBiomes()

	--declare biome:             (name,      rarity, caves,  lakes,   yspd,  xspd, b1n, b1x, b2n, b2x, trees,     treeType, layer 1 block, layer 2 block, top block)
	biomeDeclaration.declareBiome("plains",  6000,   7500,   10000,   0.01,  8,    115, 125, 3,   4,   40,        "oak",    "stone",       "dirt",        "grass")
	biomeDeclaration.declareBiome("hills",   12000,  100000, 8000,    0.5,   1,    115, 130, 3,   5,   20,        "birch",  "stone",       "dirt",        "grass")
	biomeDeclaration.declareBiome("extreme", 100000, 10000,  10000,   2,     0.5,  64,  160, 4,   7,   math.huge, "",       "stone",       "dirt",        "grass")
	biomeDeclaration.declareBiome("ocean",   9000,   100000, 1000000, 0.002, 5,    80,  96,  2,   4,   math.huge, "",       "stone",       "dirt",        "grass")
	biomeDeclaration.declareBiome("tiga",    10000,  10000,  8000,    0.05,  2,    110, 130, 2,   4,   10,        "pine",   "stone",       "dirt",        "grass")

	return biomes

end

function biomeDeclaration.declareBiome(name, rarity, caveRarity, lakeRarity, yInt, xInt, biome1Min, biome1Max, biome2Min, biome2Max, treeRarity, treeType, layer1Block, layer2Block, topBlock)
	biomes[name] = { name = name, rarity = rarity, caveRarity = caveRarity, lakeRarity = lakeRarity, yInt = yInt, xInt = xInt, biome1Min = biome1Min, biome1Max = biome1Max, biome2Min = biome2Min, biome2Max = biome2Max, treeRarity = treeRarity, treeType = treeType, layer1Block = layer1Block, layer2Block = layer2Block, topBlock = topBlock}
end

return biomeDeclaration
