-- Sudoku

local sudoku = {}

-- Grid
for i=1,9 do
  sudoku[i] = {}
  for j=1,9 do
    sudoku[i][j] = {}
    -- Number
    sudoku[i][j].number = nil
    sudoku[i][j].const = false
    sudoku[i][j].i = i
    sudoku[i][j].j = j
    -- 3x3 box
    if i <= 3 then sudoku[i][j].bx = 1
    elseif i <= 6 then sudoku[i][j].bx = 2
    else sudoku[i][j].bx = 3 end
    if j <= 3 then sudoku[i][j].by = 1
    elseif j <= 6 then sudoku[i][j].by = 2
    else sudoku[i][j].by = 3 end
    -- Graphic
    sudoku[i][j].x = 15+(i-1)*(58+5)+4*(sudoku[i][j].bx-1)
    sudoku[i][j].y = 15+(j-1)*(58+5)+4*(sudoku[i][j].by-1)
    sudoku[i][j].width = 58
    sudoku[i][j].height = 58
    -- Button
    button:new(sudoku[i][j])
    sudoku[i][j].onclick = function(self)
      if not solving then
        if self.number and self.number < 9 then
          sudoku:set(self.i,self.j,self.number+1)
        elseif self.number == 9 then
          sudoku:unset(self.i, self.j)
        else
          sudoku:set(self.i,self.j,1)
        end
      end
    end
  end
end

-- Resets the matrix
function sudoku:reset()
  for i=1,9 do
    for j=1,9 do
      self[i][j].number = nil
      self[i][j].const = false
    end
  end
end

function sudoku:set(x, y, number)
  self[x][y].number = number
  self[x][y].const = true
end
function sudoku:unset(x, y)
  self[x][y].number = nil
  self[x][y].const = false
end

function sudoku:draw()
  for i=1,9 do
    for j=1,9 do
      love.graphics.setColor(255/255,255/255,255/255)
      love.graphics.rectangle("fill", self[i][j].x, self[i][j].y, sudoku[i][j].width, sudoku[i][j].height)
      if self[i][j].const then love.graphics.setColor(255/255,0,0)
      else love.graphics.setColor(0,0,0) end
      if self[i][j].number then
        love.graphics.print(self[i][j].number, self[i][j].x+20, self[i][j].y)
      end
    end
  end
end

return sudoku
