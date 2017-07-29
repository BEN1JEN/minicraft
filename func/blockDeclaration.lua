blockDeclaration = {}

function blockDeclaration.makeBlocks()

  blocks = {}
  for id = 0, 65535 do
    blocks[id] = {
      name = "",
      id = id,
      colour = { red=0, blue=0, green=0, alpha=0 },
      drop = nil
    }
  end

  --Declare blocks

  blockDeclaration.declareBlock( blocks, "air", 0, { red=0, green=0, blue=0, alpha=0 }, nil )
  blockDeclaration.declareBlock( blocks, "cobble", 1, { red=51, green=51, blue=51, alpha=255 }, 1 )
  blockDeclaration.declareBlock( blocks, "stone", 2, { red=85, green=85, blue=85, alpha=255 }, 2 )
  blockDeclaration.declareBlock( blocks, "bedrock", 3, { red=0, green=0, blue=0, alpha=255 }, 3 )
  blockDeclaration.declareBlock( blocks, "dirt", 4, { red=91, green=58, blue=12, alpha=255 }, 4 )
  blockDeclaration.declareBlock( blocks, "grass", 5, { red=0, green=255, blue=15, alpha=255 }, 5 )
  blockDeclaration.declareBlock( blocks, "water", 6, { red=5, green=15, blue=255, alpha=255 }, nil )
  blockDeclaration.declareBlock( blocks, "log", 7, { red=5, green=15, blue=255, alpha=255 }, 7 )
  blockDeclaration.declareBlock( blocks, "leaves", 8, { red=5, green=15, blue=255, alpha=255 }, 9 )
  blockDeclaration.declareBlock( blocks, "coalOre", 10, { red=85, green=85, blue=85, alpha=255 }, 15 )
  blockDeclaration.declareBlock( blocks, "copperOre", 11, { red=85, green=85, blue=85, alpha=255 }, 11 )
  blockDeclaration.declareBlock( blocks, "ironOre", 12, { red=85, green=85, blue=85, alpha=255 }, 12 )
  blockDeclaration.declareBlock( blocks, "goldOre", 13, { red=85, green=85, blue=85, alpha=255 }, 13 )
  blockDeclaration.declareBlock( blocks, "diamondOre", 14, { red=85, green=85, blue=85, alpha=255 }, 19 )

  return blocks

end

function blockDeclaration.declareBlock ( blocks, name, id, colour, drop ) -- colour is legacy only
  blocks[id] = { name = name, colour = colour, drop = drop }
  blocks[id]["image"] = love.graphics.newImage( "assets/blocks/" .. blocks[id]["name"] .. ".png" )

  return blocks
end

return blockDeclaration
