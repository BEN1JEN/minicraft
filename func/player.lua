player = {}

function player.placePlayer(world)

  playerX = 0
  playerY = 1000
  while world[0][playerY]["ID"] == 0 do
    playerY = playerY - 1
  end

  return playerX, playerY

end

function player.movePlayer(PlayerX, playerY, playerVX, playerVY, world, dt)
  if playerVX < 1 and playerVX ~= 0 and love.keyboard.isDown("d") then
    playerVX = playerVX + 0.05
  end
  if playerVX < 1 and playerVX ~= 0 and love.keyboard.isDown("a") then
    playerVX = playerVX - 0.05
  end
  if playerVX == 0 and love.keyboard.isDown("d") then
    playerVX = playerVX + 0.1
    print("right")
  end
  if playerVX == 0 and love.keyboard.isDown("a") then
    playerVX = playerVX + 0.1
    print("left")
  end
  if world[math.floor(playerX + playerVX)][math.floor(playerY)]["ID"] == 0 then
    playerX = playerX + playerVX * dt
  end
  if world[math.floor(playerX)][math.floor(playerY + playerVY)]["ID"] == 0 then
    playerY = playerY + playerVY * dt
  end
end

return player
