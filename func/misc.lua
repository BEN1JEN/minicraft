misc = {}

function misc.getLines(filePath)
	local file = io.open(filePath, "r")
	--local i = 0
	local iter = function(file, i)
		i = i + 1
		local v = file:read("*line")
		if v then
			return i, v
		end
	end
	return iter, file, 0
end

return misc
