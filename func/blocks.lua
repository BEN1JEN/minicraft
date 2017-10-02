blockFunc = {}

function blockFunc.drawBlock(block, x, y)

	x = ( x * 20 ) + 512
	y = ( y * 20 ) + 360

	image = blocks[blockID]["texture"]

	print("drawing block at x,y: " .. x .. ", " .. y .. " ID: " .. blockID) -- debug code

	if blockID == 6 then love.graphics.setColor(255, 255, 255, 128) else
		love.graphics.setColor(255, 255, 255, 255) end
	if blockID ~= 0 then love.graphics.draw(image, x, 720-y, 0, 2, 2, 5, 5) end

end


return blockFunc
