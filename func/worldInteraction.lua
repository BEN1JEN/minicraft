worldInteraction = {}

function worldInteraction.update(hotBarSelect, world, inventory, blocks, items, playerX, playerY)

  if love.mouse.isDown(1) then

    mouseX, mouseY = love.mouse.getPosition()

    clickX, clickY =
    math.floor( (playerX + mouseX - 512)/10 + 0.5 ) * 10,
    math.floor( (playerX + mouseY - 360)/10 + 0.5 ) * 10

    for x = 1, 10 do
      for y = 1, 5 do
        if inventory[x][y] == 0 then inventory[x][y] = world[clickX][clickY]["ID"] print(world[clickX][clickY]["ID"]) break end
      end
    end

    world[clickX][clickY]["name"] = "air"
    world[clickX][clickY]["id"] = 0
    print(clickX, clickY)

  end

  return world, inventory

end

return worldInteraction
