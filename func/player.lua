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
	local run = false
	if love.keyboard.isDown("lctrl") then
		run = true
	end

	local sneek = false
	if love.keyboard.isDown("lshift") then
		sneek = true
	end

	if not(love.keyboard.isDown("a")) and not(love.keyboard.isDown("d")) then
		playerVX = 0
	elseif ( playerVX < 0.25 or ( run and playerVX < 0.5 ) ) and love.keyboard.isDown("d") then
		playerVX = playerVX + 5 * dt
	elseif ( playerVX > -0.25 or ( run and playerVX > -0.5 ) ) and love.keyboard.isDown("a") then
		playerVX = playerVX - 5 * dt
	end

	if sneek and playerVX > 0.1 then
		playerVX = 0.1
	elseif sneek and playerVX < -0.1 then
		playerVX = -0.1
	end

	if playerVY < 0.00001 and love.keyboard.isDown("w") and worldFunc.getBlock(playerX, playerY - 1)["solid"] == true then
		playerVY = playerVY + 50 * dt
	end
	playerVY = playerVY - dt * 4

	if not(sneek) then

		if worldFunc.getBlock(playerX + playerVX, playerY)["solid"] == false then
			playerX = playerX + playerVX
		elseif worldFunc.getBlock(playerX + playerVX, playerY + 1)["solid"] == false then
			playerX = playerX + playerVX
			playerY = playerY + 1
		else
			playerVX = 0
		end

	else

		if worldFunc.getBlock(playerX + playerVX, playerY)["solid"] == false and worldFunc.getBlock(playerX + playerVX, playerY - 1)["solid"] then
			playerX = playerX + playerVX
		end

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
