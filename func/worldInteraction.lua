worldInteraction = {}

function worldInteraction.update(hotBarSelect, world, inventory, blocks, items, playerX, playerY)

  local place = false

  if love.mouse.isDown(1) then

    if not(mDownLast) then

      mouseX, mouseY = love.mouse.getPosition()

      clickX, clickY =
      math.floor( (playerX + (mouseX - 512)/10) + 0.5 ),
      math.floor( (playerY + (720 - mouseY - 360)/10) + 0.5 )

      local clickedBlock = world[clickX][clickY]["ID"]

      for x = 1, 10 do
        for y = 1, 5 do
          if inventory[x][y]["ID"] == 0 and not(placed) then inventory[x][y]["ID"] = clickedBlock placed = true end
          if inventory[x][y]["ID"] == clickedBlock and not(placed) then inventory[x][y]["ID"] = clickedBlock inventory[x][y]["amount"] = inventory[x][y]["amount"]+1 placed = true end
        end
      end
      placed = false

      world[clickX][clickY]["name"] = "air"
      world[clickX][clickY]["ID"] = 0

    end
    mDownLast = true
  else
    mDownLast = false
  end

  return world, inventory

end

return worldInteraction
