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

function misc.parse(input, replacements)
	local out = input
	for i = 1, string.len(input) do
		for _, replacement in ipairs(replacements) do
			local lenReplace = string.len(replacement[1])
			--print("checking for: `" .. replacement[1] .. "` and replacing with: `" .. replacement[2] .. "`")
			if string.sub(input, i, i + lenReplace - 1) == replacement[1] then
				out = string.sub(out, 1, i - 1) .. replacement[2] .. string.sub(out, i + lenReplace, i + string.len(input))
			end
		end
	end
	return out
end

return misc
