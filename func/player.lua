player = {}

function player.placePlayer(world)

  playerX = 0
  playerY = 1000
  while world[0][playerY]["ID"] == 0 do
    playerY = playerY - 1
  end
  playerY = playerY + 1

  return playerX, playerY

end

function player.movePlayer(fallDist, health, PlayerX, playerY, playerVX, playerVY, world, dt)
  if not(love.keyboard.isDown("a")) and not(love.keyboard.isDown("d")) then
    playerVX = 0
  elseif playerVX < 0.1 and love.keyboard.isDown("d") then
    playerVX = playerVX + 5 * dt
  elseif playerVX > -0.1 and love.keyboard.isDown("a") then
    playerVX = playerVX - 5 * dt
  end

  if playerVY < 0.00001 and love.keyboard.isDown("w") and world[math.floor(playerX)][math.floor(playerY) - 1]["ID"] ~= 0 then
    playerVY = playerVY + 15 * dt
  end

  if world[math.floor(playerX)][math.floor(playerY + playerVY)]["ID"] == 0 then
    playerVY = playerVY - dt
  elseif world[math.floor(playerX)][math.floor(playerY + playerVX * dt * 200)]["ID"] == 6 then
    playerVY = playerVY - dt/4
  else

    if fallDist > 10 then
      health = health - math.floor(fallDist * 2)
    end

    playerVY = 0

  end

  if world[math.floor(playerX + playerVX * dt * 200)][math.floor(playerY)]["ID"] == 0 or  world[math.floor(playerX + playerVX * dt * 200)][math.floor(playerY)]["ID"] == 6 then
    playerX = playerX + playerVX * dt * 200
  end
  if world[math.floor(playerX)][math.floor(playerY + playerVY * dt * 200)]["ID"] == 0 or world[math.floor(playerX)][math.floor(playerY + playerVX * dt * 200)]["ID"] == 6 then

    playerY = playerY + playerVY * dt * 200
    if playerVY < 0 then
      fallDist = fallDist + playerVY * dt * -200
    else
      fallDist = 0
    end

  end

  if health < 255 then
    health = health + dt
  end

  return fallDist, health, playerX, playerY, playerVX, playerVY
end

return player
