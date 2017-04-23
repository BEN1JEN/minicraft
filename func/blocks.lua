blockFunc = {}

function blockFunc.drawBlock(blockID, x, y, blocks)

  x = ( x * 10 ) + 512
  y = ( y * 10 ) + 360
  red, green, blue, alpha = blocks[blockID]["colour"]["red"], blocks[blockID]["colour"]["green"], blocks[blockID]["colour"]["blue"], blocks[blockID]["colour"]["alpha"]
  love.graphics.setColor(red, green, blue, alpha)

  --print("drawing block at x,y: " .. x .. ", " .. y .. " ID: " .. blockID) -- debug code
  love.graphics.polygon("fill", x - 5, 720 - (y - 5), x + 5, 720 - (y - 5), x + 5, 720 - (y + 5), x - 5, 720 - (y + 5))
end

function blockFunc.getID(block, blocks)

  local ID = nil
  for i = 0, #blocks do
    if blocks[i]["name"] == block then
      ID = i
    end
  end
  return ID
end

return blocksFunc
