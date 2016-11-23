worldGen = {}

function worldGen.cave(x, y, dir, size, world)

  local cirGoal = 5
  local cirSize = 5
  local yVer = 2.5
  local dirInc = 0

  for i=1, math.random(size - 10, size + 10) do

    dir = dir + dirInc
    dirInc = dirInc + math.random(-1, 1)

    world = worldGen.circle(x, y, cirSize, world)

     x = x + math.sin(dir)
     y = y + math.cos(dir)

     if cirSize == cirGoal then

       cirGoal = math.random(0, 10)

       if cirSize == 0 then
         break
       end

     else

       local tmp = 0
       if cirSize > cirGoal then
         tmp = -1
       else
         tmp = 1
       end

       cirSize = math.random(-1, 2) * tmp

     end

  end

  return world

end

function worldGen.circle(x, y, cirSize, world)

  for c = 1, cirSize * 2 * math.pi do
    for r = 1, cirSize do
      --print("X: " .. math.floor( x + math.sin(c) * r ) * r .. ", Y: " .. math.floor( y + math.cos(c) * r ) .. ", R:" .. r .. ", C: " .. c) --debug code
      --print(world[0]) --debug code
      world[ math.floor( x + math.sin(c) * r ) ][ math.floor( y + math.sin(c) * r ) ] = { name = "air", ID = 0 }
    end
  end

  return world

end

function worldGen.genarate(biome)

  local world = {}
  local yDist1 = 0
  local yDist2 = 0
  local yInc1 = 0
  local yInc2 = 0

  for x = -1000, 1000 do
    world[x] = {}
  end

  for x = -1000, 1000 do
    for y = 0, 1000 do

        world[x][y] = { name = "air", ID = 0 }
        --print("set block X:" .. x .. ", Y" .. y .. " to:" .. "air")

    end
  end

  for x = -1000, 1000 do

    if x == -1000 then
      yDist1 = math.random(biome.biome1Min, biome.biome1Max)
      yDist2 = math.random(biome.biome2Min, biome.biome2Max)
    end

    local tmpY = 0

    --Stone layer
    for y = 0, yDist1 do
        world[x][y] = { name = "stone", ID = 2 }
        tmpY = y
    end

    --Dirt layer
    for y = tmpY, tmpY + yDist2 do
        world[x][y] = { name = "dirt", ID = 4 }
        tmpY = y
    end

    world[x][tmpY + 1] = { name = "grass", ID = 5 }

    --Stone layer
    if ( not ( yDist1 > biome.biome1Max ) ) and ( math.random(0, 1) == 0 or yDist1 < biome.biome1Min ) then
      yInc1 =  yInc1 + biome.yInt
    else
      yInc1 = yInc1 - biome.yInt
    end

    local maxYInc1 = math.abs(biome.biome1Max - biome.biome1Min) / 5
    if yInc1 > maxYInc1 then
      yInc1 = maxYInc1
    elseif yInc1 < -maxYInc1 then
      yInc1 = -maxYInc1
    end

    yDist1 = yDist1 + yInc1


    --Dirt layer
    if ( not ( yDist2 > biome.biome2Max ) ) and ( math.random(0, 1) == 0 or yDist2 < biome.biome2Min ) then
      yInc2 =  yInc2 + biome.yInt
    else
      yInc2 = yInc2 - biome.yInt
    end

    local maxYInc2 = math.abs(biome.biome2Max - biome.biome2Min) / 5
    if yInc2 > maxYInc2 then
      yInc2 = maxYInc2
    elseif yInc2 < -maxYInc2 then
      yInc2 = -maxYInc2
    end

    yDist2 = yDist2 + yInc2


    --yDist2 = math.random(biome.biome2Min, biome.biome2Max)

  end


  world = worldGen.cave(0, 25, 90, 100, world)

  --print("id:" .. world[x][y]["id"] .. ", blockName:" .. world[x][y]["name"]) --debug code
  return world

end

return worldGen
