itemFunc = {}

function itemFunc.drawItem(itemID, x, y, items)
  x = ( x * 40 ) + 300
  y = ( y * 40 ) + 240
  -- print("drawing item at x,y: " .. x .. ", " .. y .. " ID: " .. itemID) -- debug code
  red, green, blue, alpha = items[itemID]["colour"]["red"], items[itemID]["colour"]["green"], items[itemID]["colour"]["blue"], items[itemID]["colour"]["alpha"]
  love.graphics.setColor(red, green, blue, alpha)

  love.graphics.polygon("fill", x - 15, 720 - (y - 15), x + 15, 720 - (y - 15), x + 15, 720 - (y + 15), x - 15, 720 - (y + 15))
end

function itemFunc.getID(item, items)

  local ID = nil
  for i = 0, #items do
    if items[i]["name"] == item then
      ID = i
    end
  end

  return ID

end

return itemFunc
