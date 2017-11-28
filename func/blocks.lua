blockFunc = {}

function blockFunc.drawBlock(block, x, y)

	x = ( x * 20 ) + 512
	y = ( y * 20 ) + 360

	image = blocks[block]["texture"]

	--print("drawing block at x,y: " .. x .. ", " .. y .. " ID: " .. block) -- debug code
	love.graphics.draw(image, x, y, 0, 2, 2, 0, 0)

end


return blockFunc
