player = {}

function player.placePlayer(world)

	playerX = 0
	playerY = 999
	while worldFunc.getBlock(0, playerY)["name"] == "" do
		playerY = playerY - 1
	end
	playerY = playerY + 1

	return playerX, playerY

end

function player.movePlayer(fallDist, health, PlayerX, playerY, playerVX, playerVY, world, dt)
	if not(love.keyboard.isDown("a")) and not(love.keyboard.isDown("d")) then
		playerVX = 0
	elseif playerVX < 0.1 and love.keyboard.isDown("d") then
		playerVX = playerVX + 2 * dt
	elseif playerVX > -0.1 and love.keyboard.isDown("a") then
		playerVX = playerVX - 2 * dt
	end

	if playerVY < 0.00001 and love.keyboard.isDown("w") and worldFunc.getBlock(math.floor(playerX),math.floor(playerY) - 1)["solid"] == true then
		playerVY = playerVY + 15 * dt
	end

	if worldFunc.getBlock(playerX + playerVX, playerY)["solid"] == false then
		playerX = playerX + playerVX
	end
	if worldFunc.getBlock(playerX, playerY + playerVY)["solid"] == false then
		playerY = playerY + playerVY
	end

	if health < 255 then
		health = health + dt
	end

	return fallDist, health, playerX, playerY, playerVX, playerVY
end

return player
