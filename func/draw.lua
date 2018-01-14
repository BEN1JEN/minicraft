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

				if worldFunc.getBlock(x+playerX, y+playerY)["solid"] == false then
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

			--print("x, y: " .. playerX + xShift .. ", " .. playerY + yShift) -- debug code

			block = worldFunc.getBlock(playerX + xShift, playerY + yShift)["name"]
			blockFunc.drawBlock(block, xShift - (playerX - math.floor(playerX)), 0 - yShift + (playerY - math.floor(playerY)), screenBrightnesses[yShift][xShift])

		end
	end

end

function draw.drawHUD(health, inventory, invOpen, itemGrabed, items)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, 257, 12)
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.print(math.floor(health), 258, 0)
	for i = 1, math.floor(health) do
		love.graphics.line(i, 0, i, 10)
	end
	love.graphics.setColor(200, 200, 200, 255)
	love.graphics.print(fps, width/2-12, 5)
	if invOpen then
		inventoryFunc.draw(invOpen, inventory, itemGrabed, items)
	end
	inventoryFunc.drawHotbar(inventory, itemGrabed, items)

end

function draw.drawPlayer()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.polygon("fill", width/2 + 10, hight/2 + 10, width/2 + 10, hight/2 - 10, width/2 - 10, hight/2 - 10, width/2 - 10, hight/2 + 10)

end

return draw
