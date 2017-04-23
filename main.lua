function love.load()

  print("loading...")

  --requirements
  local worldGen = require "func.worldGen"
  local blocks = require "func.blocks"
  local draw = require "func.draw"
  local biomes = require "func.biomes"
  local player = require "func.player"
  local blockDeclaration = require "func.blockDeclaration"

  --math.randomseed
  math.randomseed(os.time())

  --images
  logo = love.graphics.newImage("assets/minicraftLogo.png")
  Background = love.graphics.newImage("assets/Background.png")


  --vars
  state = "title"
  playerX = 0
  playerY = 0
  playerVX = 0
  playerVY = 0
  health, inventory = 255, {}
  fps = 60
  r = 0
  fallDist = 0

  --declare blocks

  blocks = blockDeclaration.makeBlocks()

  --genarate world
  world = {}
  world = worldGen.genarate(biomes.getBiome("plains"), blocks)

  --set player location
  player.placePlayer(world)

print("done loading")

end

function love.update(dt)

  print("updateing")

  if state == "title" then
    if love.keyboard.isDown("return") then
      state = "game"
    end
  end

  if r == fps/2 then
    fps = 1/dt
    r = 0
  end
  r = r + 1
  if state == "game" then

    fallDist, health, playerX, playerY, playerVX, playerVY = player.movePlayer(fallDist, health, playerX, playerY, playerVX, playerVY, world, dt)

    if health < 1 then error("dead") end

  end

  print ("done")

end

function love.draw()
  print("drawing") --debug code

  if state == "title" then
    love.graphics.draw(Background, 0, 0, 0, 1.2, 1.5)
    love.graphics.draw(logo, 512-(521/2), 100)
  end

  if state == "game" then
    fps = math.floor(fps/2)*2

    love.graphics.setColor(66, 173, 173, 255)
    love.graphics.polygon("fill", 0, 0, 1024, 0, 1024, 720, 0, 720)
    print ("1/4") --debug code
    draw.drawWorldOld(world, blocks, playerX, playerY)
    print("2/4") --debug code

    draw.drawPlayer()
    print("3/4") --debug code
    draw.drawHUD(health, inventory)
  end

  print("4/4\ndone") --debug code

end
