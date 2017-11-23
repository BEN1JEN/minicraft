worldSave = {}
function worldSave.save(world, worldName)

  local worldFile = io.open(worldName, "w")

  for x = 0, #world do
    for y = 0, #world[x] do

      local block = string.char(world[x][y]["ID"])
      worldFile:write(block)

    end
  end

end

return worldSave
