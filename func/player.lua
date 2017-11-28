player = {}

local playerVX = 0
local playerVY = 0
local fallDist = 0

function player.placePlayer()

	playerX = 0
	playerY = 1024
	while worldFunc.getBlock(0, playerY)["solid"] == false do
		playerY = playerY - 1
	end
	playerY = playerY + 1

end

function player.movePlayer(dt)
	--print("PVX	PVY:", playerVX, playerVY)
	if not(love.keyboard.isDown("a")) and not(love.keyboard.isDown("d")) then
		playerVX = 0
	elseif playerVX < 0.01 and love.keyboard.isDown("d") then
		playerVX = playerVX + 1 * dt
	elseif playerVX > -0.01 and love.keyboard.isDown("a") then
		playerVX = playerVX - 1 * dt
	end

	if playerVY < 0.00001 and love.keyboard.isDown("w") and worldFunc.getBlock(playerX, playerY - 1)["solid"] == true then
		playerVY = playerVY + 100 * dt
	end
	playerVY = playerVY - dt * 9

	if worldFunc.getBlock(playerX + playerVX, playerY)["solid"] == false then
		playerX = playerX + playerVX
	elseif worldFunc.getBlock(playerX + playerVX, playerY + 1)["solid"] == false then
		playerX = playerX + playerVX
		playerY = playerY + 1
	else
		playerVX = 0
	end
	if worldFunc.getBlock(playerX, playerY + playerVY)["solid"] == false then
		playerY = playerY + playerVY
	else
		playerVY = 0
	end

	if health < 255 then
		health = health + dt
	end

end

return player
