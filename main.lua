function love.load()

	print("loading...")

	--vars
	startTime = os.time()
	state = "title"
	playerX = 0
	playerY = 0
	playerVX = 0
	playerVY = 0
	health, inventory = 255, {}
	fps = 60
	r = 0
	fallDist = 0
	invOpen = true
	itemGrabed = { ID = 0, amount = 0 }
	hotBarSelect = 1

	--requirements
	local worldGen = require "func.worldGen"
	local blockFunc = require "func.blocks"
	local itemFunc = require "func.item"
	local draw = require "func.draw"
	local biomes = require "func.biomes"
	local player = require "func.player"
	local blockDeclaration = require "func.blockDeclaration"
	local itemDeclaration = require "func.itemDeclaration"
	local inventoryFunc = require "func.inventory"
	local worldInteraction = require "func.worldInteraction"
	local worldFunc = require "func.worldFunc"

	--math.randomseed
	math.randomseed(startTime%2^32)
	print("seed: " .. startTime%2^32)

	--images
	logo = love.graphics.newImage("assets/minicraftLogo.png")
	Background = love.graphics.newImage("assets/Background.png")

	--declare blocks and items
	items = itemDeclaration.declareItems()
	blocks = blockDeclaration.declareBlocks()

	--genarate world
	world = {}
	worldGen.genarate(biomes.getBiome("plains"), -1000, 1000)

	--set player location
	player.placePlayer()

	-- initalize inventorty
	inventory = inventoryFunc.init(inventory)

print("done loading in " .. os.time() - startTime .. "ms")


end

function exit()

	os.execute("cls")
	error()

end

function love.update(dt)

	-- print("updateing") --debug code

	if love.keyboard.isDown("q") then exit() end



	if state == "title" then
		if love.keyboard.isDown("return") then
			state = "game"
		end
		if love.keyboard.isDown("p") then
			state = "pano"
			love.window.setMode(3072, 720, {resizable=false, vsync=false, minwidth=3072, minheight=720})
		end
	end

	if r == fps/2 then
		fps = 1/dt
		r = 0
	end
	r = r + 1
	if state == "game" then

		player.movePlayer(dt)

		--print("PX	PY:", playerX, playerY)

		if health < 1 then error("dead") end

		itemGrabed, invOpen, inventory = inventoryFunc.update(itemGrabed, invOpen, inventory)

		if not(invOpen) then
			world, inventory = worldInteraction.update(hotBarSelect)
		end

		--worldGen.updateWorld(biomes.getBiome("plains"), blocks, playerX, playerY)

	end

	-- print ("done") --debug code

end

function love.draw()
	-- print("drawing") --debug code

	if state == "title" then
		love.graphics.draw(Background, 0, 0, 0, 1.2, 1.5)
		love.graphics.draw(logo, 512-(521/2), 100)
	end

	if state == "game" or state == "pano" then
		fps = math.floor(fps/2)*2

		love.graphics.setColor(66, 173, 173, 255)
		love.graphics.polygon("fill", 0, 0, 3072, 0, 3072, 720, 0, 720)
		love.graphics.setColor(255, 255, 255, 255)
		-- print ("1/4") --debug code
		--if state == "pano" then draw.drawWorld(260)
		--else
			draw.drawWorld(52)
		--end
		-- print("2/4") --debug code

		if state ~= "pano" then draw.drawPlayer() end
		-- print("3/4") --debug code
		if state ~= "pano" then draw.drawHUD(health, inventory, invOpen, itemGrabed, items) end
	end

	-- print("4/4\ndone") --debug code

end
