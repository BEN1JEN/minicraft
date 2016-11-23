draw = {}

function draw.drawWorldOld(world, blocks)

local block = ""

  for xShift = -52, 52 do
    for yShift = -36, 36 do

      --print("x, y: " .. playerX + xShift .. ", " .. playerY + yShift) -- debug code

      if world[math.floor(playerX) + xShift] ~= nil and world[math.floor(playerX) + xShift][math.floor(playerY) + yShift] ~= nil then
        block = world[math.floor(playerX) + xShift][math.floor(playerY) + yShift]["name"]
        blockFunc.drawBlock(blockFunc.getID(block), xShift, yShift, blocks)
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

function draw.drawHUD(health, inventory, playerX, playerY)

  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.rectangle("fill", 0, 0, 257, 12)
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.print(health, 258, 0)
  for i = 1, health do
    love.graphics.line(i, 0, i, 10)
  end

end

return draw
