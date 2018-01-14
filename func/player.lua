player = {}

local playerVX = 0
local playerVY = 0
local fallFromY = false

function player.placePlayer()

	playerX = 0
	playerY = 1024
	while worldFunc.getBlock(0, playerY)["solid"] == false do
		playerY = playerY - 1
	end
	playerY = playerY + 1

end

function player.getInput()

	local buttons = {}
	if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
		buttons.runButton = true
	end
	if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
		buttons.sneekButton = true
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		buttons.leftButton = true
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		buttons.rightButton = true
	end
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") or love.keyboard.isDown("space") then
		buttons.jumpButton = true
	end
	return buttons

end

function player.movePlayer(dt)

	--print("PVX	PVY:", playerVX, playerVY) -- debug code

	-- get buttons
	local buttons = player.getInput()

	-- get run and sneek
	local run = false
	if buttons.runButton then
		run = true
	end
	local sneek = false
	if buttons.sneekButton then
		sneek = true
	end

	--get wasd input
	if not(buttons.leftButton) and not(buttons.rightButton) then
		playerVX = 0
	elseif ( playerVX < 0.25 or ( run and playerVX < 0.5 ) ) and buttons.rightButton then
		playerVX = playerVX + 5 * dt
	elseif ( playerVX > -0.25 or ( run and playerVX > -0.5 ) ) and buttons.leftButton then
		playerVX = playerVX - 5 * dt
	end

	if sneek and playerVX > 0.1 then
		playerVX = 0.1
	elseif sneek and playerVX < -0.1 then
		playerVX = -0.1
	end

	if playerVY < 0.00001 and buttons.jumpButton and worldFunc.getBlock(playerX, playerY - 1)["solid"] == true then
		playerVY = playerVY + 50 * dt
	end
	playerVY = playerVY - dt * 4

	-- update playerX
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

	-- update playerY
	if worldFunc.getBlock(playerX, playerY + playerVY)["solid"] == false then
		playerY = playerY + playerVY
	else
		playerVY = 0
	end

	-- world wrap
	if playerY < -1024 then
		playerY = 2048
	elseif playerY > 2048 then
		playerY = -1024
	end

	-- fall damage calculation
	if playerVY > 0 then
		fallFromY = playerY
	end
	if fallFromY and worldFunc.getBlock(playerX, playerY - 1)["solid"] then
		local fallDist = fallFromY - playerY
		if fallDist > 8 then
			health = health - fallDist * 4
		end
		fallFromY = false

	end

	-- health regen
	if health < 255 then
		health = health + dt * 8
	end

end

return player
