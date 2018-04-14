itemDeclaration = {}

function itemDeclaration.declareItems()

	items = {}
	--Declare items
	itemDeclaration.declareItem( "", 0, print, "hello")

	return items

end

function itemDeclaration.declareItem ( name, texture, useFunction, usePramater )
	items[name] = { name=name, useFunction=useFunction,  usePramater=usePramater }

	return items
end

function itemDeclaration.declareBlockItems ()
	for block in blocks do
		itemDeclaration.declareItem( block.name, block.texture, worldInteraction.placeItem, block.name )
	end
end

return itemDeclaration
