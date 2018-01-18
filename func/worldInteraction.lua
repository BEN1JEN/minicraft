worldInteraction = {}
function worldInteraction.convertMouseToBlock(mouseX, mouseY)

	local clickY =
		math.floor( (playerY + (720 - mouseY - 360)/20) + 0.5 )
	local clickX =
		math.floor( playerX + math.floor((mouseX + 4 - 507) / 20) + 0.5)

		return clickX, clickY

end

function worldInteraction.breakBlock(mouseX, mouseY)
	local clickX, clickY = worldInteraction.convertMouseToBlock(mouseX, mouseY)

	worldFunc.setBlock(clickX, clickY, "air")

	for _, item in ipairs(worldFunc.getBlock(clickX, clickY)["drops"]) do
		if math.random(1, worldFunc.getBlock(clickX, clickY)["drops"][i]["prob"]) == 1 then
			inventoryFunc.give(worldFunc.getBlock(clickX, clickY)["drops"][i])
		end
	end

end

function worldInteraction.update(hotBarSelect)

	local place = false

	if love.mouse.isDown(1) then
		if not(mDownLast) then

			if playerX > 0 then
				clickX = clickX + 0
			end

			worldInteraction.breakBlock(love.mouse.getPosition())

		end
		mDownLast = true
	else
		mDownLast = false
	end

	return world, inventory

end

return worldInteraction
