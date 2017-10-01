worldInteraction = {}

function worldInteraction.update(hotBarSelect, world, inventory, blocks, items, playerX, playerY)

	local place = false

	if love.mouse.isDown(1) then

		if not(mDownLast) then

			mouseX, mouseY = love.mouse.getPosition()

			clickY =
				math.floor( (playerY + (720 - mouseY - 360)/20) + 0.5 )

			clickX =
				math.floor( playerX + math.floor((mouseX - 507) / 20) + 0.5)

			if playerX > 0 then
				clickX = clickX + 0
			end

			local clickedBlock = blocks[world[clickX][clickY]["ID"]]["drop"]

			if clickedBlock ~= nil then
				for y = 1, 5 do
					for x = 1, 10 do
						if inventory[x][y]["ID"] == clickedBlock and not(placed) then
							inventory[x][y]["ID"] = clickedBlock
							inventory[x][y]["amount"] = inventory[x][y]["amount"] + 1
							placed = true
						end
					end
				end

				for y = 1, 5 do
					for x = 1, 10 do
						if inventory[x][y]["ID"] == 0 and not(placed) then
							inventory[x][y]["ID"] = clickedBlock
							inventory[x][y]["amount"] = 1
							placed = true
						end
					end
				end
				placed = false

				world[clickX][clickY]["name"] = "air"
				world[clickX][clickY]["ID"] = 0
			end

		end
		mDownLast = true
	else
		mDownLast = false
	end

	return world, inventory

end

return worldInteraction
