local fallFromY = false

function player.die(cause)
	local messages = {}
	if cause == "fall" then
		for _, line in misc.getLines(love.filesystem.getSource() .. "/assets/texts/fallDeath.txt") do
			messages[#messages + 1] = misc.parse(line, {{"*player", player.name}})
		end
	end
	chatFunc.send(messages[math.random(1, #messages)])
	player.health = 255
end

function player.placePlayer()

	player.x = 0
	player.y = 1024
	while worldFunc.getBlock(0, player.y)["solid"] == false do
		player.y = player.y - 1
	end
	player.y = player.y + 1

end

function player.getInput()

	local buttons = {}
	if mode == "pc" then
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
	elseif mode == "mobile" then
		for _, button in pairs(onScreenButtons) do

			onScreenButtons[id]["pressed"] = false

			for id, touch in pairs(love.touch.getTouches()) do
				touchX, touchY = love.touch.getPosition(id)
				if touchX >= button.x and touchX <= button.x + button.width and touchY >= button.y and touchY <= button.y + button.hight then
					buttons[id] = true
					onScreenButtons[id]["pressed"] = true
				end
			end

		end
	end
	return buttons

end

function player.movePlayer(dt)

	--print("PVX	PVY:", player.vx, player.vy) -- debug code

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
		player.vx = 0
	elseif ( player.vx < 0.25 or ( run and player.vx < 0.5 ) ) and buttons.rightButton then
		player.vx = player.vx + 5 * dt
	elseif ( player.vx > -0.25 or ( run and player.vx > -0.5 ) ) and buttons.leftButton then
		player.vx = player.vx - 5 * dt
	end

	if sneek and player.vx > 0.1 then
		player.vx = 0.1
	elseif sneek and player.vx < -0.1 then
		player.vx = -0.1
	end

	if player.vy < 0.00001 and buttons.jumpButton and worldFunc.getBlock(player.x, player.y - 1)["solid"] == true then
		player.vy = player.vy + 50 * dt
	end
	player.vy = player.vy - dt * 4

	-- update player.x
	if not(sneek) then

		if worldFunc.getBlock(player.x + player.vx, player.y)["solid"] == false then
			player.x = player.x + player.vx
		elseif worldFunc.getBlock(player.x + player.vx, player.y + 1)["solid"] == false then
			player.x = player.x + player.vx
			player.y = player.y + 1
		else
			player.vx = 0
		end

	else

		if worldFunc.getBlock(player.x + player.vx, player.y)["solid"] == false and worldFunc.getBlock(player.x + player.vx, player.y - 1)["solid"] then
			player.x = player.x + player.vx
		end

	end

	-- update player.y
	if worldFunc.getBlock(player.x, player.y + player.vy)["solid"] == false then
		player.y = player.y + player.vy
	else
		player.vy = 0
	end

	-- world wrap
	if player.y < -1024 then
		player.y = 2048
	elseif player.y > 2048 then
		player.y = -1024
	end

	-- fall damage calculation
	if player.vy > 0 then
		fallFromY = player.y
	end
	if fallFromY and worldFunc.getBlock(player.x, player.y - 1)["solid"] then
		local fallDist = fallFromY - player.y
		if fallDist > 8 then
			player.health = player.health - fallDist * 4
		end
		fallFromY = false

	end

	-- health regen
	if player.health < 255 then
		player.health = player.health + dt * 4
	end

end

return player
