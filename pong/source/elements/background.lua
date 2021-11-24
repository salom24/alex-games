--! file: background.lua

background = {}

function background:load()
  self.width, self.height = love.graphics.getDimensions()
  -- Table with the middle lines
  local length = (self.height - 60) / 9
  local position = 30
  self.lines = {}
  for i=1,5 do
    table.insert(self.lines, {self.width/2, position, self.width/2, position + length})
    position = position + 2 * length
  end
end

function background:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, self.width, self.height)
  love.graphics.setColor(255/255, 255/255, 255/255)
  love.graphics.rectangle("fill", 30, 30, self.width - 60, self.height - 60)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setLineWidth(10)
  for i=1,5 do
    love.graphics.line(self.lines[i])
  end
end
