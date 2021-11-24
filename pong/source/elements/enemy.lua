enemy = {}

function enemy:load()
  self.height = 100
  self.width = 20
  self.side = "right"
  self.x = love.graphics.getWidth() - 50 - self.width
  self.y = (love.graphics.getHeight() - self.height) / 2
  self.speed = 150
  self.color = {43/255, 86/255, 197/255, 255/255}
end

function enemy:update(dt)
  local aim = ball.aim.y
  if self.y + self.height/2 + 5 < aim then
    self.y = self.y + self.speed * dt
    if self.y + self.height >= love.graphics.getHeight() - 30 then
      self.y = love.graphics.getHeight() - self.height - 30
    end
  elseif self.y + self.height/2 - 5 > aim then
    self.y = self.y - self.speed * dt
    if self.y <= 30 then self.y = 30 end
  end
end

function enemy:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.width/2)
end
