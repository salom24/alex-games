-- quit.lua

local quit = {}

function quit:load()
  self.time = 0
  self.fadeOut = 0
  self.fadeIn = 0
  self.font = love.graphics.newFont("fonts/HighVoltage.ttf", 100)
end

function quit:update(dt)
  self.time = self.time + dt
  if self.time < 3 then
    self.fadeOut = self.time * 255/3
  elseif self.time < 6 then
    self.fadeIn = (self.time-3) * 255/3
  elseif self.time > 9 then
    love.event.quit()
  end
end

function quit:draw()
  if self.time < 3 then
    background:draw()
    player:draw()
    enemy:draw()
    ball:draw()
    score:draw()
  end
  love.graphics.setColor(255/255,255/255,255/255,self.fadeOut)
  love.graphics.rectangle("fill", 0, 0, width,height)
  love.graphics.setColor(0, 0, 0, self.fadeIn)
  love.graphics.setFont(self.font)
  if score.scoreP1 == 6 then
    love.graphics.printf("Player wins!", 0, 200, width, "center")
  elseif score.scoreP2 == 6 then
    love.graphics.printf("Computer wins...", 0, 200, width, "center")
  else
    love.graphics.printf("Goodbye!", 0, 200, width, "center")
  end

end

return quit
