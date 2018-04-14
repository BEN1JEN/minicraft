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

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, 257, 12)
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.print(math.floor(player.health), 258, 0)
	for i = 1, math.floor(player.health) do
		love.graphics.line(i, 0, i, 10)
	end
	love.graphics.setColor(200, 200, 200, 255)
	love.graphics.print(fps, 500, 0)
	if invOpen then
		inventoryFunc.draw(invOpen)
	end
	inventoryFunc.drawHotbar()
	chatFunc.draw()

end

function draw.drawPlayer()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.polygon("fill", 1024/2 + 10, 720/2 + 10, 1024/2 + 10, 720/2 - 10, 1024/2 - 10, 720/2 - 10, 1024/2 - 10, 720/2 + 10)

end

return draw
