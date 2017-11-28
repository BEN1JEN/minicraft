inventoryFunc = {}

function inventoryFunc.draw(invOpen, inventory, itemGrabed, items)

	local mouseX, mouseY = love.mouse.getPosition()
	local itemX, itemY = ((mouseX+300)/40-15), 6-((mouseY+240)/40-12)
	local itemRealX, itemRealY = math.floor((mouseX+20)/40+.5)*40-20, math.floor((mouseY)/40+.5)*40

	-- draw inventory
	love.graphics.setColor(128,128,128,255)
	love.graphics.polygon( "fill", 720, 260, 720, 460, 320, 460, 320, 260 )

	love.graphics.setColor(255, 255, 255, 128)
	if itemRealX >= 340 and itemRealY >= 280 and itemRealX <= 700 and itemRealY <= 440 then
		love.graphics.polygon( "fill", itemRealX+20, itemRealY+20, itemRealX+20, itemRealY-20, itemRealX-20, itemRealY-20, itemRealX-20, itemRealY+20 )
	end

	for x = 1, 10 do
		for y = 1, 5 do
			local tmpX, tmpY = (x*40)-300, 6-(y*40)-240
			itemFunc.drawItem(inventory[x][y]["ID"], x, y, items, inventory[x][y]["amount"])

		end
	end

	itemFunc.drawItem(itemGrabed["ID"], itemX, itemY, items, itemGrabed["amount"])

end

function inventoryFunc.init(inventory)

	for x = 1, 10 do
		inventory[x] = {}
	end

	for y = 1, 5 do
		for x = 1, 10 do
			inventory[x][y] = {ID = 0, amount = 0}
		end
	end

	inventory[10][5] = { ID = 5, amount = 1}

	return inventory

end

function inventoryFunc.update(itemGrabed, invOpen, inventory)
	if invOpen then

		local mouseX, mouseY = love.mouse.getPosition()
		local itemX, itemY = (math.floor((mouseX+320)/40)-15), 6-(math.floor((mouseY+260)/40)-12)
		if love.mouse.isDown(1) or love.mouse.isDown(2) then
			if not(mDownLast) and mouseX >= 320 and mouseY >= 260 and mouseX <= 720 and mouseY <= 460 then

				if love.mouse.isDown(1) then
					if inventory[itemX][itemY]["ID"] ~= itemGrabed["ID"] then
						print("swap")
						local tmp = itemGrabed
						itemGrabed = inventory[itemX][itemY]
						inventory[itemX][itemY] = tmp
					elseif inventory[itemX][itemY]["ID"] == itemGrabed["ID"] then
						print("add")
						inventory[itemX][itemY]["amount"] = inventory[itemX][itemY]["amount"] + itemGrabed["amount"]
						itemGrabed["amount"], itemGrabed["ID"], itemGrabed["name"] = 0, 0, ""
					end
				elseif love.mouse.isDown(2) then
					if itemGrabed["ID"] == inventory[itemX][itemY]["ID"] or ( inventory[itemX][itemY]["ID"] == 0 and itemGrabed["ID"] ~= 0 ) then
						print("sub")
						inventory[itemX][itemY]["ID"] = itemGrabed["ID"]
						inventory[itemX][itemY]["amount"] = inventory[itemX][itemY]["amount"] + 1
						itemGrabed["amount"] = itemGrabed["amount"] - 1

						if itemGrabed["amount"] == 0 then itemGrabed["ID"] = 0 itemGrabed["name"] = "" end
						if inventory[itemX][itemY]["amount"] == 0 then itemGrabed["ID"] = 0 itemGrabed["name"] = "" end
					elseif itemGrabed["ID"] == 0 and inventory[itemX][itemY]["ID"] ~= 0 then
						print("dev")
						itemGrabed["ID"] = inventory[itemX][itemY]["ID"]
						itemGrabed["amount"] = math.floor(inventory[itemX][itemY]["amount"]/2)
						inventory[itemX][itemY]["amount"] = math.ceil(inventory[itemX][itemY]["amount"]/2)

						if itemGrabed["amount"] == 0 then itemGrabed["ID"] = 0 itemGrabed["name"] = "" end
						if inventory[itemX][itemY]["amount"] == 0 then itemGrabed["ID"] = 0 itemGrabed["name"] = "" end

					end
				end
			end
			mDownLast = true
		else
			mDownLast = false
		end


	end

	if love.keyboard.isDown("e") then
		if not(eDownLast) then invOpen = not(invOpen) end
		eDownLast = true
	else
		eDownLast = false
	end

	if love.keyboard.isDown("escape") then invOpen = false end

	return itemGrabed, invOpen, inventory

end

function inventoryFunc.drawHotbar(inventory, itemGrabed, items)

		local mouseX, mouseY = love.mouse.getPosition()
		local itemX, itemY = ((mouseX+300)/40-15), 6-((mouseY+240)/40-12)
		local itemRealX, itemRealY = math.floor((mouseX+20)/40+.5)*40-20, math.floor((mouseY+20)/40+.5)*40-20

		love.graphics.setColor(128,128,128,255)
		love.graphics.polygon( "fill", 720, 680, 720, 720, 320, 720, 320, 680 )

		love.graphics.setColor(255, 255, 255, 128)
		if itemRealX >= 340 and itemRealY >= 680 and itemRealX <= 700 and itemRealY <= 720 then
			love.graphics.polygon( "fill", itemRealX+20, itemRealY+20, itemRealX+20, itemRealY-20, itemRealX-20, itemRealY-20, itemRealX-20, itemRealY+20 )
		end

		for x = 1, 10 do
			itemFunc.drawItem(inventory[x][1]["ID"], x, -5.5, items, inventory[x][1]["amount"])
		end

end

return inventoryFunc
