blockDeclaration = {}

function blockDeclaration.declareBlocks()

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
	blockDeclaration.declareBlock(nil, "air", -1, nil, {})
	blockDeclaration.declareBlock("stone", "stone", 15, "pickaxe", {{item="cobblestone", prob=1}})
	blockDeclaration.declareBlock("cobblestone", "cobblestone", 10, "pickaxe", {{item="cobblestone", prob=1}})
	blockDeclaration.declareBlock("oakBark", "oakLog", 3, "axe", {{item="oakWood", prob=1},{item="oakBark", prob=5}})
	blockDeclaration.declareBlock("dirt", "dirt", 2, "shovel", {{item="dirt", prob=1},{item="pebble", prob=10}})
	blockDeclaration.declareBlock("grassBlock", "grass", 15, "pickaxe", {{item="dirt", prob=1}})
	blockDeclaration.declareBlock("leaves", "oakLeaves", 2, "shears", {{item="oakSapling", prob=2},{item="apple", prob=5}})
	blockDeclaration.declareBlock("coalOre", "coalOre", 15, "pickaxe", {{item="coalOre", prob=1}})
	blockDeclaration.declareBlock("ironOre", "ironOre", 15, "pickaxe", {{item="ironOre", prob=1}})
	blockDeclaration.declareBlock("copperOre", "copperOre", 15, "pickaxe", {{item="copperOre", prob=1}})
	blockDeclaration.declareBlock("goldOre", "goldOre", 15, "pickaxe", {{item="goldOre", prob=1}})


	return blocks

end




function blockDeclaration.declareBlock ( texture, name, hardness, tool, drops )
	blocks[name] = { name=name, drops=drops, hardness=hardness, tool=tool }
	if texture then
		blocks[name]["texture"] = love.graphics.newImage( "assets/blocks/" .. texture .. ".png" )
	end

	return blocks
end

return blockDeclaration
