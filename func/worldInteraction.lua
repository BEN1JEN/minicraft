worldInteraction = {}
function worldInteraction.convertMouseToBlock(mouseX, mouseY)

	local clickY =
		math.floor( (playerY + (720 - mouseY - 360)/20) + 0.5 )
	local clickX =
		math.floor( playerX + math.floor((mouseX - 507) / 20) + 0.5)

		return clickX, clickY

end
function worldInteraction.breakBlock(x, y)

end
function worldInteraction.update(hotBarSelect)

	local place = false

	if love.mouse.isDown(1) then

		if not(mDownLast) then

			local mouseX, mouseY = love.mouse.getPosition()

			local clickX, clickY = worldInteraction.convertMouseToBlock(mouseX, mouseY)

			if playerX > 0 then
				clickX = clickX + 0
			end

			worldFunc.setBlock(clickX, clickY, "air")
			--local clickedBlock = blocks[world[clickX][clickY]["ID"]["drop"]

			if clickedBlock ~= nil then
				for y = 1, 5 do
					for x = 1, 10 do
						if inventory[x][y]["ID"] == clickedBlock or inventory[x][y]["ID"] == 0 and not(placed) then
							inventory[x][y]["ID"] = clickedBlock
							inventory[x][y]["amount"] = inventory[x][y]["amount"] + 1
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
