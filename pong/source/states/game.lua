-- game.lua

local game = {}

function game:load()
  require "source.elements.background"
  require "source.elements.player"
  require "source.elements.enemy"
  require "source.elements.ball"
  require "source.elements.score"

  background:load()
  player:load()
  enemy:load()
  ball:load()
  score:load()

  self.time = 0
end

function game:update(dt)
  self.time = self.time + dt

  player:update(dt)
  if self.time > 1 then
    enemy:update(dt)
    ball:update(dt)
    ball:checkPadCollision(player)
    ball:checkPadCollision(enemy)
  end
  score:update(dt)
end

function game:draw()
  background:draw()
  player:draw()
  enemy:draw()
  ball:draw()
  score:draw()
end

return game
