function love.load( args )

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
	invOpen = false
	itemGrabed = { ID = 0, amount = 0 }
	hotBarSelect = 1
	biomes = {}
	chat = {}
	sendMessage = nil

	OS = love.system.getOS()
	mode = "pc"
	width, hight = love.graphics.getDimensions()
	resMode = 604
	onScreenButtons = {
		jumpButton = {x = width-100, y = hight-100, width =  50, hight =  50, pressed =  false},
		runButton = {x = width-100, y = hight-200, width = 50, hight = 50, pressed = false},
		leftButton = {x = 50, y = hight-150, width = 50, hight = 50, pressed = false},
		rightButton = {x = 150, y = hight-150, width = 50, hight = 50, pressed = false}
	}

	--set propper mode and resolution
	if OS == "iOS" or OS == "Android" then
		print("mobile mode active.", 10, 10)
		mode = "mobile"
	end

	if mode == "mobile" then
		local boarder = 1024
		love.window.setMode(width, hight)
		if width > 512+boarder then
			resMode = 512
		elseif width > 384+boarder then
			resMode = 384
		elseif width > 256+boarder then
			resMode = 256
		elseif width > 192+boarder then
			resMode = 192
		elseif width > 128+boarder then
			resMode = 128
		end

		if hight >= 720 then
			love.window.setMode(width, hight, {highdpi = true})
			highdpi = true
		end
	else
		love.window.setMode(1024, 720, {fullscreen = true})
		--love.window.setMode(1280, 720)
	end

	--if highdpi then
		onScreenButtons = {
		jumpButton = {x = width-400, y = hight-400, width =  200, hight = 200, pressed =  false},
		runButton = {x = width-400, y = hight-800, width = 200, hight = 200, pressed = false},
		leftButton = {x = 400, y = hight-600, width = 200, hight = 200, pressed = false},
		rightButton = {x = 600, y = hight-600, width = 200, hight = 200, pressed = false}
	}
	--end

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

	--math.randomseed
	seed = startTime%2^24
	--seed = 88888888888
	math.randomseed(seed)
	print("seed: " .. seed)

	--images
	logo = love.graphics.newImage("assets/minicraftLogo" .. resMode .. ".png")
	Background = love.graphics.newImage("assets/Background.png")

	--declare biomes, blocks and items
	items = itemDeclaration.declareItems()
	blocks = blockDeclaration.declareBlocks()
	biomes = biomeDeclaration.declareBiomes()
	biome = biomes.plains

	--genarate world
	worldGen.genarate(biomes.plains, -10, 10)

	--set player location
	player.placePlayer()

	-- initalize inventorty
	inventory = inventoryFunc.init(inventory)

print("done loading in " .. os.time() - startTime .. "s")


end

function exit()

	os.execute("cls")
	error()

end

function love.update(dt)

	if mode == "pc" then
		-- print("updateing") --debug code

		if love.keyboard.isDown("q") then exit() end

		if state == "title" then
			if love.keyboard.isDown("return") then
				state = "game"
			end
			if love.keyboard.isDown("p") then
				state = "pano"
				playerY = playerY + 8
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

			--print("PX	PY:", playerX, playerY)

			if player.health < 1 then player.die("fall") end

			inventoryFunc.update()

			if not(invOpen) then
				worldInteraction.update(hotBarSelect)
			end

			worldGen.updateWorld()

		end

		-- print ("done") --debug code
	elseif mode == "mobile" then

			if state == "title" then

					if #love.touch.getTouches() > 0 then
							state = "game"
					end

			elseif state == "game" then

				player.movePlayer(dt)

			end

	end

end

function love.draw()
	-- print("drawing") --debug code

	if state == "title" then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(Background, 0, 0, 0, width/1920, hight/1080)
		love.graphics.draw(logo, width/2-resMode/2, 100)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.print(OS .. " running in " .. mode .. " mode.", 10, 10)
	end

	if state == "game" or state == "pano" then

		fps = math.floor(fps/2)*2

		love.graphics.setColor(0.25, 0.68, 0.68, 1)
		love.graphics.polygon("fill", 0, 0, 6144, 0, 6144, 1440, 0, 1440)
		love.graphics.setColor(1, 1, 1, 1)
		-- print ("1/4") --debug code
		if state == "pano" then
			draw.drawWorld(math.ceil(width/2))
		else
			draw.drawWorld(math.ceil(width/20))
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
