itemDeclaration = {}

function itemDeclaration.makeItems()

	items = {}
	for id = 0, 65535 do
		items[id] = {
			name = "",
			id = id,
			colour = { red=0, blue=0, green=0, alpha=0 }
		}
	end

	--Declare items

	itemDeclaration.declareItem( items, "", 0, { red=0, green=0, blue=0, alpha=0 } )
	itemDeclaration.declareItem( items, "cobble", 1, { red=51, green=51, blue=51, alpha=255 } )
	itemDeclaration.declareItem( items, "stone", 2, { red=85, green=85, blue=85, alpha=255 } )
	itemDeclaration.declareItem( items, "bedrock", 3, { red=0, green=0, blue=0, alpha=255 } )
	itemDeclaration.declareItem( items, "dirt", 4, { red=91, green=58, blue=12, alpha=255 } )
	itemDeclaration.declareItem( items, "grass", 5, { red=0, green=255, blue=15, alpha=255 } )

	return items

end

function itemDeclaration.declareItem ( items, name, id, colour )
	items[id] = { name = name, colour = colour }

	return items
end

return itemDeclaration
