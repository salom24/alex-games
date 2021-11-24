-- intro.lua

local intro = {}

function intro:load()
  -- Variables of the scene
  self.time = 0
  -- Load fonts
  self.mainFont = love.graphics.newFont("fonts/HighVoltage.ttf", 200)
  self.subFont = love.graphics.newFont("fonts/HelvetiPixel.ttf", 50)
  -- Colors for the init screen
  self.backgroundColor = {255/255,255/255,255/255}
  self.fontColor = {0,0,0,255/255}
  -- Blink of the message
  self.blink = true
  self.playGame = false
end

function intro:update(dt)
  self.time = self.time + dt -- Add time to total
  if self.playGame then -- When SPACE has been pressed
    if self.time % .2 > .1 then self.blink = false
    else self.blink = true end
    -- Delay to start the game
    if self.time > .6 then currentScene = "game" end
  else -- When SPACE has not been pressed
    if self.time % 1 > .7 then self.blink = false
    else self.blink = true end
  end
  -- Input handle
  if love.keyboard.isDown("space") then
    self.playGame = true
    self.time = 0
  elseif love.keyboard.isDown("q") then
    currentScene = "quit"
  end
end

function intro:draw()
  love.graphics.setBackgroundColor(self.backgroundColor)
  love.graphics.setColor(self.fontColor)
  love.graphics.setFont(self.mainFont)
  love.graphics.printf("PONG", 0, 50, love.graphics.getWidth(), "center")
  if self.blink then
    love.graphics.setFont(self.subFont)
    love.graphics.printf("Press SPACE", 0, 400, love.graphics.getWidth(), "center")
  end
end

return intro
