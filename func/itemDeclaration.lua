itemDeclaration = {}

function itemDeclaration.declareItems()

	items = {}
	for id = 0, 65535 do
		items[id] = {
			name = "",
			id = id,
			colour = { red=0, blue=0, green=0, alpha=0 }
		}
	end

	--Declare items

	itemDeclaration.declareItem( "", 0, { red=0, green=0, blue=0, alpha=0 } )

	return items

end

function itemDeclaration.declareItem ( name, texture, useFunction )
	items[name] = { name=name, useFunction=useFunction }

	return items
end

function itemDeclaration.declareBlockItems ()
	for block in blocks do
		itemDeclaration.declareItem( block[name], block[name], nil )
	end
end

return itemDeclaration
