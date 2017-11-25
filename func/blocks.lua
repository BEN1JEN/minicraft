blockFunc = {}

function blockFunc.drawBlock(block, x, y)

	x = ( x * 20 ) + 512
	y = ( y * 20 ) + 360

	image = blocks[block]["texture"]

	if block ~= "air" then
		print("drawing block at x,y: " .. x .. ", " .. y .. " ID: " .. block) -- debug code
	end

end


return blockFunc
