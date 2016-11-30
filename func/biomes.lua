biomes = {}

function biomes.getBiome(biome)

  if biome == "plains" then
    ret = {
      caveRarity = 1000,
      lakeRarity = 10000,
      yInt = 0.05,
      xInt = 2,
      biome1Min = 40,
      biome1Max = 45,
      biome2Min = 3,
      biome2Max = 4
    }
  elseif biome == "hills" then
    ret = {
      yInt = 0.5,
      xInt = 1,
      biome1Min = 40,
      biome1Max = 53,
      biome2Min = 3,
      biome2Max = 5
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
      biome2Max = 4
    }
  elseif biome == "extreme" then
    ret = {
      yInt = 1,
      xInt = 1,
      biome1Min = 40,
      biome1Max = 200,
      biome2Min = 4,
      biome2Max = 7
    }
  end

  return ret

end

return biomes
