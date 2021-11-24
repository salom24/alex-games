-- score.lua

score = {}

function score:load()
  -- Score of each player
  self.scoreP1 = 0
  self.scoreP2 = 0
  -- Load font and color
  self.font = love.graphics.newFont("fonts/HelvetiPixel.ttf", 100)
  self.color = {0, 0, 0, 255/255}
end

function score:update(dt)
  if self.scoreP1 == 6 or self.scoreP2 == 6 or love.keyboard.isDown("q") then
    currentScene = "quit"
  end
end

function score:draw()
  love.graphics.setColor(self.color)
  love.graphics.setFont(self.font)
  love.graphics.printf(self.scoreP1, 50, 50, love.graphics.getWidth()/2 - 70, "center")
  -- love.graphics.printf("-", love.graphics.getWidth()/2 - 20, 40, 40, "center")
  love.graphics.printf(self.scoreP2, love.graphics.getWidth()/2 + 20, 50, love.graphics.getWidth()/2 - 70, "center")
end
