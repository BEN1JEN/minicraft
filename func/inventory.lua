inventoryFunc = {}

function inventoryFunc.draw(invOpen, inventory)
  local mouseX, mouseY = love.mouse.getPosition()
  love.graphics.setColor(128,128,128,255)
  love.graphics.polygon( "fill", 712, 560, 712, 260, 312, 260, 312, 560 )
  love.graphics.setColor(255, 255, 255, 128)
  local itemX, itemY = math.floor((mouseX+20)/40+.5)*40-20, math.floor((mouseY+20)/40+.5)*40-20
  love.graphics.polygon( "fill", itemX+20, itemY+20, itemX+20, itemY-20, itemX-20, itemY-20, itemX-20, itemY+20 )
end

function inventoryFunc.init(inventory)

  for x = 1, 10 do
    inventory[x] = {}
  end

  for y = 1, 5 do
    for x = 1, 10 do
      inventory[x][y] = {item = "", id = 0}
    end
  end

end

function inventoryFunc.update(itemGrabed, invOpen, inventory)
  if invOpen then

    local mouseX, mouseY = love.mouse.getPosition()

    if love.mouse.isDown and mouseX < 713 and mouseX > 311 and mouseY > 259 and mouseY < 561 then
      local tmp = itemGrabed
      itemGrabed = inventory[math.floor((mouseX+312)/40)][math.floor((mouseY+260)/40)]
      inventory[math.floor((mouseX+512)/40)][math.floor((mouseY+360)/40)] = tmp
    end

  end
end

return inventoryFunc
