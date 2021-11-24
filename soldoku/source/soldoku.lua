-- Sudoku solver

-- Iterate through sudoku
function nexts(sudoku, x, y)
  repeat
    if x < 9 then
      x = x + 1
    else
      x = 1
      y = y + 1
      if y > 9 then return "end" end
    end
  until not sudoku[x][y].const
  return x, y
end
function previous(sudoku, x, y)
  repeat
    if x > 1 then
      x = x - 1
    else
      x = 9
      y = y - 1
      if y < 1 then return "fail" end
    end
  until not sudoku[x][y].const
  return x, y
end

-- Check lines, columns and boxes
function line(sudoku, x, y, number)
  for i=1,9 do
    if number == sudoku[i][y].number then
      return false
    end
  end
  return true
end
function column(sudoku, x, y, number)
  for i=1,9 do
    if number == sudoku[x][i].number then
      return false
    end
  end
  return true
end
function box(sudoku, x, y, number)
  local bx = sudoku[x][y].bx - 1
  local by = sudoku[x][y].by - 1
  for i=1,3 do
    for j=1,3 do
      if number == sudoku[3*bx + i][3*by + j].number then
        return false
      end
    end
  end
  return true
end

-- Solves a number
function solve1(sudoku, x, y)
  local nx = false
  local ind = 1
  if not sudoku[x][y].const then
    if sudoku[x][y].number then ind = sudoku[x][y].number + 1 end
    for i=ind,9 do
      if line(sudoku,x,y,i) and column(sudoku,x,y,i) and box(sudoku,x,y,i) then
        sudoku[x][y].number = i
        nx = true
        break
      end
    end
  else
    nx = true
  end
  if nx then
    return nexts(sudoku, x, y)
  else
    sudoku[x][y].number = nil
    return previous(sudoku, x, y) end
end

-- Buttons
solver = {
  x = 600,
  y = 15,
  width = 185,
  height = 90
}
button:new(solver)
function solver:onclick()
  if not soving then
    solving = true
  end
end
function solver:draw()
  love.graphics.setColor(0,255/255,0)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.setColor(0,0,0)
  love.graphics.print("SOLVE", self.x+25, self.y+2)
end

reset = {
  x = 600,
  y = 120,
  width = 185,
  height = 90
}
button:new(reset)
function reset:onclick()
  solving = nil
  itx, ity = 1, 1
  sudoku:reset()
end
function reset:draw()
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.setColor(255,255,255)
  love.graphics.print("RESET", self.x+25, self.y+2)
end

fast = {
  x = 600,
  y = 225,
  width = 185,
  height = 90
}
button:new(fast)
function fast:onclick()
  itx, ity = 1, 1
  solving = true
  for i=1,9 do
    for j=1,9 do
      if not sudoku[i][j].const then
        sudoku[i][j].number = nil
      end
    end
  end
  while itx ~= "end" and itx ~= "fail" do
    itx, ity = solve1(sudoku, itx, ity)
  end
end
function fast:draw()
  love.graphics.setColor(0,0,255/255)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.setColor(255/255,255/255,255/255)
  love.graphics.print("FAST", self.x+25, self.y+2)
end
