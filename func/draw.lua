draw = {}

function draw.drawWorld(xMax)

	local block = ""
	for xShift = xMax*-1, xMax do
		for yShift = -18, 18 do

			--print("x, y: " .. playerX + xShift .. ", " .. playerY + yShift) -- debug code

			block = worldFunc.getBlock(playerX + xShift, playerY + yShift)["name"]
			blockFunc.drawBlock(block, xShift - (playerX - math.floor(playerX)), 0 - yShift + (playerY - math.floor(playerY)))
			--blockFunc.drawBlock(block, xShift, 0-yShift)

		end
	end

end
--[[
function draw.drawWorldOld(world)

	sx = 0
	for bx = math.max(-1000,math.floor(playerX)-52),math.min(1000, math.floor(playerX)+52) do
		sx = sx + 1
		sy = 0
		for by = math.max(0,math.floor(playerY)-36),math.min(1000, math.floor(playerY)+36) do
			sy = sy + 1
			blockFunc.drawBlock(world[bx][by]["ID"], sx, sy, blocks)
		end
	end

end
]]
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
