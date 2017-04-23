local inventory = {}

function inventory.draw(inventory)

end

function inventory.init(inventory)

  for x = 1, 10 do
    inventory[x] = {}
  end

  for y = 1, 5 do
    for x = 1, 10, do
      inventory[x][y] = {item = "", id = 0}
    end
  end

end

function inventory.update(itemGrabed, invOpen, inventory)
  if invOpen then

    local mouseX, mouseY = love.mouse.getPosition()

    if love.mouse.isDown and mouseX =< 712 and mouseX => 312 and mouseY => 260 mouseY =< 560 then
      local tmp = itemGrabed
      itemGrabed = inventory[round((mouseX+312)/40)][round((mouse+260)/40)]
      inventory[round((mouseX+512)/40)][round((mouse+360)/40)] == tmp
    end

  end
end
