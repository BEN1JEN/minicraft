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

  --declare blocks

  blockDeclaration.makeBlocks()

  --genarate world
  world = {}
  world = worldGen.genarate(biomes.getBiome("plains"))

  --set player location
  player.placePlayer(world)

print("done loading")

end

function love.update(dt)

  if state == "title" then
    if love.keyboard.isDown("return") then
      state = "game"
    end
  end

  print("updateing fps:" .. 1/dt) -- debug code
  if state == "game" then

    player.movePlayer(PlayerX, playerY, playerVX, playerVY, world, dt)

  end

end

function love.draw()
  --print("drawing") --debug code

  if state == "title" then
    love.graphics.draw(Background, 0, 0, 0, 1.2, 1.5)
    love.graphics.draw(logo, 512-(521/2), 100)
  end

  if state == "game" then
    love.graphics.setColor(66, 173, 173, 255)
    love.graphics.polygon("fill", 0, 0, 1024, 0, 1024, 720, 0, 720)
    draw.drawWorldOld(world, blocks)

    draw.drawHUD(health, inventory, playerX, playerY)
  end
end
