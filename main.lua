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
	invOpen = false
	itemGrabed = { ID = 0, amount = 0 }
	hotBarSelect = 1
	biomes = {}
	OS = love.system.getOS()
	mode = "pc"
	width, hight = love.graphics.getDimensions()
	resMode = 604


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
		onScreenButtons = {
			jumpButton = {x = width-100, y = hight-100, width =  50, hight =  50, pressed =  false},
			runButton = {x = width-100, y = hight-200, width = 50, hight = 50, pressed = false},
			leftButton = {x = 50, y = hight-150, width = 50, hight = 50, pressed = false},
			rightButton = {x = 150, y = hight-150, width = 50, hight = 50, pressed = false}
		}
		if width >= 1080 then
			love.window.setMode(width, hight, {highdpi = true})
		end
	else
		love.window.setMode(1024, 720, {fullscreen = true})
		--love.window.setMode(1280, 720)
	end

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

						if health < 1 then error("dead") end

						itemGrabed, invOpen, inventory = inventoryFunc.update(itemGrabed, invOpen, inventory)

						if not(invOpen) then
								world, inventory = worldInteraction.update(hotBarSelect)
						end

						worldGen.updateWorld(playerX, playerY)

				end

				-- print ("done") --debug code
		elseif mode == "mobile" then

				if state == "title" then

						if #love.touch.getTouches() > 0 then
								state = "game"
						end

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

		if mode == "mobile" then
			for i, button in pairs(onScreenButtons) do
				local opacity = 0
				if button.pressed then
					opacity = 127
				else
					opacity = 255
				end
				love.graphics.setColor(255, 255, 255, opacity)
				love.graphics.rectangle("fill", button.x, button.y, button.width, button.hight)
			end
		end

		fps = math.floor(fps/2)*2

		love.graphics.setColor(66, 173, 173, 255)
		love.graphics.polygon("fill", 0, 0, 6144, 0, 6144, 1440, 0, 1440)
		love.graphics.setColor(255, 255, 255, 255)
		-- print ("1/4") --debug code
		if state == "pano" then
			draw.drawWorld(math.ceil(width/2))
		else
			draw.drawWorld(math.ceil(width/20))
		end
		-- print("2/4") --debug code

		if state ~= "pano" then draw.drawPlayer() end
		-- print("3/4") --debug code
		if state ~= "pano" then draw.drawHUD(health, inventory, invOpen, itemGrabed, items) end
	end

	-- print("4/4\ndone") --debug code

end
