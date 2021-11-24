-- Buttons

local button = {}
button.list = {}

local id = 1

function button:new(object)
  local name = object.name or id
  id = id + 1
  self.list[name] = object
end

function button:delete(object)
  if object.name and self.list[object.name] then
    self.list[object.name] = nil
  else
    for i,v in pairs(self.list) do
      if v == object then
        table.remove(self.list, i)
      end
    end
  end
end

function button:click(x,y)
  for _,v in pairs(self.list) do
    if v.x and v.y and v.width and v.height then
      if x >= v.x and x < v.x + v.width and y >= v.y and y < v.y + v.height then
        if v.onclick then v:onclick() end
      end
    end
  end
end

return button
