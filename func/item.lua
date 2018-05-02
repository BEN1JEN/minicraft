itemFunc = {}

function itemFunc.drawItem(item, invX, invY, amount)
	x = ( invX * 40 ) + 300
	y = ( invY * 40 ) + 240
	-- print("drawing item at x,y: " .. x .. ", " .. y .. " ID: " .. itemID) -- debug code
	love.graphics.setColor(0, 0, 0, 1)

	love.graphics.polygon("fill", x - 15, 720 - (y - 15), x + 15, 720 - (y - 15), x + 15, 720 - (y + 15), x - 15, 720 - (y + 15))

	if amount > 1 then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.print(tostring(amount), x, 720-y)
	end
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
