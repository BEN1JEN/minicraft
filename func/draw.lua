draw = {}

function draw.drawWorld(xMax)

	-- Calculate brightness
	--NOPE
	local screenBrightnesses = {}
	for y = 37, -36, -1 do
		screenBrightnesses[y] = {}
		for x = xMax, -xMax, -1 do
			if y == 37 or x == xMax then
				brightness = 1
			else
				aboveBrightness = math.max(screenBrightnesses[y+1][x+1], screenBrightnesses[y+1][x])
				if x > -xMax then
					aboveBrightness = math.max(aboveBrightness, screenBrightnesses[y+1][x-1])
				end

				if worldFunc.getBlock(x+player.x, y+player.y)["solid"] == false then
					brightness = aboveBrightness
				else
					brightness = aboveBrightness - 0.05
				end
			end
			if brightness < 0 then
				brightness = 0
			end
			screenBrightnesses[y][x] = brightness
		end
	end

	-- Draw
	local block = ""
	for xShift = xMax*-1, xMax do
		for yShift = -36, 37 do

			--print("x, y: " .. player.x + xShift .. ", " .. player.y + yShift) -- debug code

			block = worldFunc.getBlock(player.x + xShift, player.y + yShift)["name"]
			blockFunc.drawBlock(block, xShift - (player.x - math.floor(player.x)), 0 - yShift + (player.y - math.floor(player.y)), screenBrightnesses[yShift][xShift])

		end
	end

end

function draw.drawHUD(inventory, invOpen, itemGrabed, items)

	if mode == "mobile" then
		for i, button in pairs(onScreenButtons) do

			local opacity = 0
			if button.pressed then
				opacity = 0.5
			else
				opacity = 1
			end
			print(button.x, button.y, button.width, button.hight)
			love.graphics.setColor(1, 1, 1, opacity)
			love.graphics.rectangle("fill", button.x, button.y, button.width, button.hight)
		end
	end

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("fill", 0, 0, 257, 12)
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.print(math.floor(player.health), 258, 0)
	for i = 1, math.floor(player.health) do
		love.graphics.line(i, 0, i, 10)
	end
	love.graphics.setColor(0.8, 0.8, 0.8, 1)
	love.graphics.print(fps, width/2-12, 5)
	if invOpen then
		inventoryFunc.draw(invOpen)
	end
	inventoryFunc.drawHotbar()
	chatFunc.draw()

end

function draw.drawPlayer()

	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.polygon("fill", width/2 + 10, hight/2 + 10, width/2 + 10, hight/2 - 10, width/2 - 10, hight/2 - 10, width/2 - 10, hight/2 + 10)

end

return draw
