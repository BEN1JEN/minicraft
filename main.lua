function love.load()

	print("loading...")

	--vars
	startTime = os.time()
	state = "title"
	player = {}
	player.x = 0
	player.y = 0
	player.vy = 0
	player.vy = 0
	player.name = "BEN1JEN"
	player.health = 255
	inventory = {}
	fps = 60
	r = 0
	fallDist = 0
	invOpen = true
	itemGrabed = { ID = 0, amount = 0 }
	hotBarSelect = 1
	biomes = {}
	chat = {}
	sendMessage = nil

	-- fonts
	chatFont = love.graphics.newFont("assets/fonts/Menlo-Regular.ttf", 12)

	--requirements
	local worldGen = require "func.worldGen"
	local blockFunc = require "func.blocks"
	local itemFunc = require "func.item"
	local draw = require "func.draw"
	local biomeDeclaration = require "func.biomes"
	local player = require "func.player"
	local blockDeclaration = require "func.blockDeclaration"
	local itemDeclaration = require "func.itemDeclaration"
	local inventoryFunc = require "func.inventory"
	local worldInteraction = require "func.worldInteraction"
	local worldFunc = require "func.worldFunc"
	local misc = require "func.misc"
	local chatFunc = require "func.chat"

	print(misc.parse("hello my name is *name", {{"*name", "bobby"}}))

	--math.randomseed
	seed = startTime%2^24
	--seed = 88888888888
	math.randomseed(seed)
	print("seed: " .. seed)

	--images
	logo = love.graphics.newImage("assets/minicraftLogo.png")
	Background = love.graphics.newImage("assets/Background.png")

	--declare biomes, blocks and items
	items = itemDeclaration.declareItems()
	blocks = blockDeclaration.declareBlocks()
	biomes = biomeDeclaration.declareBiomes()
	biome = biomes.plains

	--genarate world
	world = {}
	worldGen.genarate(biomes.plains, -10, 10)

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
			player.y = player.y + 8
			love.window.setMode(6144, 1200, {resizable=false, vsync=false, minwidth=3072, minheight=720})
			worldGen.genarate(biomes.plains, -128, 1024)
		end
	end

	if r == fps/2 then
		fps = 1/dt
		r = 0
	end
	r = r + 1
	if state == "game" then

		player.movePlayer(dt)

		--print("PX	PY:", player.x, player.y)

		if player.health < 1 then player.die("fall") end

		itemGrabed, invOpen, inventory = inventoryFunc.update(itemGrabed, invOpen, inventory)

		if not(invOpen) then
			world, inventory = worldInteraction.update(hotBarSelect)
		end

		worldGen.updateWorld(player.x, player.y)

		chatFunc.update()

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
		love.graphics.polygon("fill", 0, 0, 6144, 0, 6144, 1440, 0, 1440)
		love.graphics.setColor(255, 255, 255, 255)
		-- print ("1/4") --debug code
		if state == "pano" then
			draw.drawWorld(520)
		else
			draw.drawWorld(52)
		end
		-- print("2/4") --debug code

		if state ~= "pano" then draw.drawPlayer() end
		-- print("3/4") --debug code
		if state ~= "pano" then draw.drawHUD(inventory, invOpen, itemGrabed, items) end
	end

	-- print("4/4\ndone") --debug code

end

function love.textinput(char)
	if sendMessage then
		sendMessage = sendMessage .. char
	end
end
