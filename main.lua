function love.load()

  logo = love.graphics.newImage("assets/minicraftLogo.png")
  Background = love.graphics.newImage("assets/Background.png")
  state = "title"

end

function love.update(dt)

end

function love.draw()
  if state == "logo" then
    love.graphics.draw(HelloDotWorld)
  end
  if state == "title" then
    love.graphics.draw(Background, 0, 0, 0, 1.2, 1.3)
    love.graphics.draw(logo, 512-(521/2), 100)
  end
end
