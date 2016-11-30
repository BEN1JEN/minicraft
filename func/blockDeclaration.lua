blockDeclaration = {}

function blockDeclaration.makeBlocks()

  blocks = {}
  for id = 1, 65535 do
    blocks[id] = {
      name = "",
      id = id,
      colour = { red=0, blue=0, green=0, alpha=0 }
    }
  end

  --Declare blocks

  blockDeclaration.declareBlock( blocks, "air", 255, { red=0, green=0, blue=0, alpha=0 } )
  blockDeclaration.declareBlock( blocks, "cobble", 1, { red=51, green=51, blue=51, alpha=255 } )
  blockDeclaration.declareBlock( blocks, "stone", 2, { red=85, green=85, blue=85, alpha=255 } )
  blockDeclaration.declareBlock( blocks, "bedrock", 3, { red=0, green=0, blue=0, alpha=255 } )
  blockDeclaration.declareBlock( blocks, "dirt", 4, { red=91, green=58, blue=12, alpha=255 } )
  blockDeclaration.declareBlock( blocks, "grass", 5, { red=0, green=255, blue=15, alpha=255 } )
  blockDeclaration.declareBlock( blocks, "water", 6, { red=5, green=15, blue=255, alpha=255 } )

  return blocks

end

function blockDeclaration.declareBlock ( blocks, name, id, colour )
  blocks[id] = { name = name, colour = colour }
end

return blockDeclaration
