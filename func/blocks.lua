blockFunc = {}

function blockFunc.drawBlock(block, x, y, brightness)

	love.graphics.setColor(255, 255, 255, 255)
	x = ( x * 20 ) + 512
	y = ( y * 20 ) + 360

	image = blocks[block]["texture"]

	--print("drawing block at x,y: " .. x .. ", " .. y .. " ID: " .. block) -- debug code
	if image then
		love.graphics.draw(image, x, y, 0, 2, 2, 5, 5)
	end
	if brightness then
		love.graphics.setColor(0, 0, 0, brightness * 255)
		love.graphics.rectangle("fill", x-10, y-10, 20, 20)
	end

end


return blockFunc
