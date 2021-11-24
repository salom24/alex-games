--! file: player.lua

player = {}

function player:load()
  self.height = 100
  self.width = 20
  self.side = "left"
  self.x = 50
  self.y = (love.graphics.getHeight() - self.height) / 2
  self.speed = 250
  self.color = {43/255, 86/255, 197/255, 255/255}
end

function player:update(dt)
  if love.keyboard.isDown("down") and not love.keyboard.isDown("up") then
    self.y = self.y + self.speed * dt
    if self.y + self.height >= love.graphics.getHeight() - 30 then
      self.y = love.graphics.getHeight() - self.height - 30
    end
  elseif love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
    self.y = self.y - self.speed * dt
    if self.y <= 30 then self.y = 30 end
  end
end

function player:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.width/2)
end
