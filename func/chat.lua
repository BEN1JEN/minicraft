chatFunc = {}

local enterDownLast = true

function chatFunc.send(message)

	local chatLen = #chat + 1
	chat[chatLen] = message
end

function chatFunc.draw()

	for x, line in ipairs(chat) do
		love.graphics.setColor(255, 255, 255)
		love.graphics.setFont(chatFont)
		love.graphics.print(line, 0, x*12)
	end

	if sendMessage then
		love.graphics.print(sendMessage, 0, #chat*12+12)
	end

end

function chatFunc.update()
	if love.keyboard.isDown("kpenter") or love.keyboard.isDown("return") then
		if not(enterDownLast) then
			enterDownLast = true
			if sendMessage then
				chatFunc.send(player.name .. ": " .. sendMessage)
				sendMessage = nil
			else
				sendMessage = ""
			end
		end
	else
		enterDownLast = false
	end
end

return chatFunc
