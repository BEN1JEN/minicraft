worldInteraction = {}
function worldInteraction.convertMouseToBlock(mouseX, mouseY)
	mouseY = 720-mouseY
	local clickX = math.floor(0.5 + player.x + (mouseX/20 - 512/20 - player.x + math.floor(player.x)) + (player.x - math.floor(player.x)))
	local clickY = math.floor(0.5 + player.y + (mouseY/20 - 360/20 - player.y + math.floor(player.y)))
	--local clickY =
	--	math.floor( (player.y + (720 - mouseY - 360)/20) + 0.5 )
	--local clickX =
	--	math.floor( player.x + math.floor((mouseX + 4 - 507) / 20) + 0.5)

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

function worldInteraction.placeItem(item, block)
	setBlock(worldInteraction.convertMouseToBlock(love.mouse.getPosition()), block)
end

function worldInteraction.update(hotBarSelect)

	local place = false

	if love.mouse.isDown(1) then
		if not(mDownLast) then

			worldInteraction.breakBlock(love.mouse.getPosition())

		end
		mDownLast = true
	else
		mDownLast = false
	end

	return world, inventory

end

return worldInteraction
