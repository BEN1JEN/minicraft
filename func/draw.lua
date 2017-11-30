draw = {}

function draw.drawWorld(xMax)

	-- Calculate brightness
	local screenBrightnesses = {}
	for x = xMax*-1, xMax do
		screenBrightnesses[x] = {}
		for y = -18, 18 do
			if x == xMax*-1 or y == -18 then
				brightness = 1
			elseif worldFunc.getBlock(x-1+playerX, y-1+playerY-1)["solid"] == false then
				brightness = screenBrightnesses[x-1][y-1]
			elseif worldFunc.getBlock(x+playerX-1, y+playerY-1)["solid"] == true then
				brightness = screenBrightnesses[x-1][y-1] - 0.1
			end
			screenBrightnesses[x][y] = brightness
		end
	end

	-- Draw
	local block = ""
	for xShift = xMax*-1, xMax do
		for yShift = -18, 19 do

			--print("x, y: " .. playerX + xShift .. ", " .. playerY + yShift) -- debug code

			block = worldFunc.getBlock(playerX + xShift, playerY + yShift)["name"]
			blockFunc.drawBlock(block, xShift - (playerX - math.floor(playerX)), 0 - yShift + (playerY - math.floor(playerY)), screenBrightnesses[xShift][yShift])

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
	love.graphics.print(fps, 500, 0)
	if invOpen then
		inventoryFunc.draw(invOpen, inventory, itemGrabed, items)
	end
	inventoryFunc.drawHotbar(inventory, itemGrabed, items)

end

function draw.drawPlayer()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.polygon("fill", 1024/2 + 10, 720/2 + 10, 1024/2 + 10, 720/2 - 10, 1024/2 - 10, 720/2 - 10, 1024/2 - 10, 720/2 + 10)

end

return draw
