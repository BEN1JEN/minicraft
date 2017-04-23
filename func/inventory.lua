inventoryFunc = {}

function inventoryFunc.draw(invOpen, inventory, items)

  local mouseX, mouseY = love.mouse.getPosition()

  love.graphics.setColor(128,128,128,255)
  love.graphics.polygon( "fill", 720, 260, 720, 460, 320, 460, 320, 260 )

  love.graphics.setColor(255, 255, 255, 128)
  local itemX, itemY = math.floor((mouseX+20)/40+.5)*40-20, math.floor((mouseY)/40+.5)*40
  if itemX >= 340 and itemY >= 280 and itemX <= 700 and itemY <= 440 then
    love.graphics.polygon( "fill", itemX+20, itemY+20, itemX+20, itemY-20, itemX-20, itemY-20, itemX-20, itemY+20 )
  end

  for x = 1, 10 do
    for y = 1, 5 do
      itemFunc.drawItem(inventory[x][y], x, y, items)
    end
  end

end

function inventoryFunc.init(inventory)

  for x = 1, 10 do
    inventory[x] = {}
  end

  for y = 1, 5 do
    for x = 1, 10 do
      inventory[x][y] = 0
    end
  end

  inventory[10][1] = 5

  return inventory

end

function inventoryFunc.update(itemGrabed, invOpen, inventory)
  if invOpen then

    local mouseX, mouseY = love.mouse.getPosition()

    if love.mouse.isDown() and mouseX >= 340 and mouseY >= 280 and mouseX <= 700 and mouseY <= 440 then
      local tmp = itemGrabed
      local itemX, itemY = math.floor((mouseX+320)/40)-15, math.floor((mouseY+260)/40)-12
      itemGrabed = inventory[itemX][itemY]
      inventory[itemX][itemY] = tmp
    end

  end

  if love.keyboard.isDown("e") then
    if not(eDownLast) then invOpen = not(invOpen) end
    eDownLast = true
  else
    eDownLast = false
  end

  return itemGrabed, invOpen, inventory

end

return inventoryFunc
