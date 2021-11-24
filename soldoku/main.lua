-- main | SOLDOKU

function love.load()
  button = require "source.button"
  sudoku = require "source.sudoku"
  require "source.soldoku"
  font = love.graphics.newFont("fonts/HighVoltage.ttf", 42)
  bigfont = love.graphics.newFont("fonts/HighVoltage.ttf", 62)
  itx, ity = 1, 1
end

function love.update(dt)
  if solving then
    if itx ~= "end" and itx ~= "fail" then
      itx, ity = solve1(sudoku, itx, ity)
    end
  end
end

function love.draw()
  love.graphics.setFont(font)
  sudoku:draw()
  love.graphics.setFont(bigfont)
  solver:draw()
  reset:draw()
  fast:draw()
  if itx == "fail" then
    love.graphics.setColor(255/255,0,0)
    love.graphics.rectangle("line", 0, 230, 600, 140)
    love.graphics.setColor(255/255,255/255,255/255)
    love.graphics.rectangle("fill", 0, 230, 600, 140)
    love.graphics.setColor(255/255,0,0)
    love.graphics.print("Ops... something is wrong", 20, 250)
  end
end

function love.mousereleased(x,y)
  button:click(x, y)
end
