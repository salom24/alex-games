--! file: ball.lua

ball = {}

function ball:load()
  -- Position
  self.x = 200
  self.y = height/2 - 10
  self.radius = 10
  --Movement
  self.speed = 500
  self.angle = love.math.random(-45, 45)
  if self.angle < 0 then self.angle = self.angle + 360 end
  self.speedX = 0
  self.speedY = 0
  -- Draw
  self.color = {255/255, 0, 0, 255/255}
  -- Aiming point
  self.aim = {x = 0, y = 0}
end

function ball:checkPadCollision(pad)
  if self.x > pad.x + pad.width then return false end
  if self.x + 2 * self.radius < pad.x then return false end
  if self.y > pad.y + pad.height then return false end
  if self.y + 2 * self.radius < pad.y then return false end

  if pad.side == "left" then
    local dist = self.y + self.radius - pad.y - pad.height/2
    self.angle = dist * 60 / (pad.height/2 + self.radius)
    if self.angle < 0 then self.angle = self.angle + 360 end
  elseif pad.side == "right" then
    local dist = self.y + self.radius - pad.y - pad.height/2
    self.angle = 180 - dist * 60 / (pad.height/2 + self.radius)
  end
  return true
end

function ball:update(dt)
  -- Update speed
  self.speedX = self.speed * math.cos(math.rad(self.angle))
  self.speedY = self.speed * math.sin(math.rad(self.angle))

  -- Aim point
  if self.speedX > 0 then
    self.aim.y = (width - 70 - self.x - 2 * self.radius) * math.tan(math.rad(self.angle)) + self.y + self.radius
    self.aim.x = width - 70
  else
    self.aim.y = (70 - self.x) * math.tan(math.rad(self.angle)) + self.y + self.radius
    self.aim.x = 70
  end
  if self.aim.y > height - 30 - self.radius or self.aim.y < 30 + self.radius then
    if self.speedY > 0 then
      self.aim.x = (height - 30 - self.y - 2 * self.radius) / math.tan(math.rad(self.angle)) + self.x + self.radius
      self.aim.y = height - 30
    else
      self.aim.x = (30 - self.y) / math.tan(math.rad(self.angle)) + self.x + self.radius
      self.aim.y = 30
    end
  end

  -- Update position
  self.x = self.x + dt * self.speedX
  -- If touches right side
  if self.x + 2 * self.radius >= width - 30 then
    score.scoreP1 = score.scoreP1 + 1
    if score.scoreP1 < 6 then
      self.x = 200
      self.y = height/2 - 10
      self.angle = love.math.random(-45, 45)
      if self.angle < 0 then self.angle = self.angle + 360 end
      scenes[currentScene].time = 0
    end
  -- If ball touches left side
  elseif self.x <= 30 then
    score.scoreP2 = score.scoreP2 + 1
    if score.scoreP2 < 6 then
      self.x = width - 200
      self.y = height/2 - 10
      self.angle = love.math.random(135, 225)
      scenes[currentScene].time = 0
    end
  end

  self.y = self.y + dt * self.speedY
  if self.y + 2 * self.radius >= height - 30 then
    self.y = height - 2 * self.radius - 30
    self.angle = 360 - self.angle
  elseif self.y <= 30 then
    self.y = 30
    self.angle = 360 - self.angle
  end
end

function ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", math.abs(self.x + self.radius), math.abs(self.y+ self.radius), self.radius, 100)
  -- Print aim point
  -- love.graphics.setColor(0, 255, 0)
  -- love.graphics.circle("fill", self.aim.x, self.aim.y, 4)
end
