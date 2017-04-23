draw = {}

function draw.drawWorldOld(world, blocks, playerX, playerY)

local block = ""

  for xShift = -52, 52 do
    for yShift = -36, 36 do

      -- print("x, y: " .. playerX + xShift .. ", " .. playerY + yShift) -- debug code

      if world[math.floor(playerX) + xShift] ~= nil and world[math.floor(playerX) + xShift][math.floor(playerY) + yShift] ~= nil then
        block = world[math.floor(playerX) + xShift][math.floor(playerY) + yShift]["ID"]
        -- print(block) -- debug code
        blockFunc.drawBlock(block, xShift, yShift, blocks)
      end

    end
  end

end

function draw.drawWorld(world, blocks)

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

end

function draw.drawPlayer()


  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.polygon("fill", 1024/2 + 5, 720/2 + 5, 1024/2 + 5, 720/2 - 5, 1024/2 - 5, 720/2 - 5, 1024/2 - 5, 720/2 + 5)

end

return draw
