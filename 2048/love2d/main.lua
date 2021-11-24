-- Local variables
local lg = love.graphics
local numbers
local changable
local side
local state

-- Local functions
local function addNumber()
	local x, y
	repeat
		x = love.math.random(4)
		y = love.math.random(4)
	until not numbers[x][y]
	numbers[x][y] = love.math.random() > 0.9 and 4 or 2
end

local function checkState()
	for x = 1, 4 do
		for y = 1, 4 do
			if not numbers[x][y] then
				return true
			else
				for a = x-1, x+1 do
					for b = y-1, y+1 do
						if (x == a and y ~= b) or (x ~= a and y == b) then
							if numbers[x][y] == numbers[a][b] then
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end

local function moveRight()
	for x = 3, 1, -1 do
		for y = 1, 4 do
			if numbers[x][y] then
				local n = numbers[x][y]
				numbers[x][y] = nil
				local i = x + 1
				while i < 4 and not numbers[i][y] do i = i + 1 end
				if numbers[i][y] == n then
					numbers[i][y] = n * 2
				elseif not numbers[i][y] then
					numbers[i][y] = n
				else
					numbers[i-1][y] = n
				end
			end
		end
	end
end

local function moveLeft()
	for x = 2, 4 do
		for y = 1, 4 do
			if numbers[x][y] then
				local n = numbers[x][y]
				numbers[x][y] = nil
				local i = x - 1
				while i > 1 and not numbers[i][y] do i = i - 1 end
				if numbers[i][y] == n then
					numbers[i][y] = n * 2
				elseif not numbers[i][y] then
					numbers[i][y] = n
				else
					numbers[i+1][y] = n
				end
			end
		end
	end
end

local function moveUp()
	for x = 1, 4 do
		for y = 2, 4 do
			if numbers[x][y] then
				local n = numbers[x][y]
				numbers[x][y] = nil
				local i = y - 1
				while i > 1 and not numbers[x][i] do i = i - 1 end
				if numbers[x][i] == n then
					numbers[x][i] = n * 2
				elseif not numbers[x][i] then
					numbers[x][i] = n
				else
					numbers[x][i+1] = n
				end
			end
		end
	end
end

local function moveDown()
	for x = 1, 4 do
		for y = 3, 1, -1 do
			if numbers[x][y] then
				local n = numbers[x][y]
				numbers[x][y] = nil
				local i = y + 1
				while i < 4 and not numbers[x][i] do i = i + 1 end
				if numbers[x][i] == n then
					numbers[x][i] = n * 2
				elseif not numbers[x][i] then
					numbers[x][i] = n
				else
					numbers[x][i-1] = n
				end
			end
		end
	end
end

-- Love2d main functions
function love.load()
	numbers = {{}, {}, {}, {}}
	side = 80
	state = "play"
	lg.setNewFont(side)
	addNumber()
	addNumber()
end
-- Love2d main functions
function love.load()
	numbers = {{}, {}, {}, {}}
	side = 80
	state = "play"
	lg.setNewFont(side)
	addNumber()
	addNumber()
end

function love.draw()
	lg.translate(10, 10)
	for x = 1, 4 do
		for y = 1, 4 do
			if numbers[x][y] then
				lg.setColor(1, 1, 1)
				lg.rectangle("fill", x * (side+5), y * (side+5), side, side)
				lg.setColor(.3, .4, .3)
				lg.print(numbers[x] and numbers[x][y] or " ",
					x * (side+5), y * (side+5))
			end
		end
	end
end

-- Keyboard handle
function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "right" then
		moveRight()
		addNumber()
	elseif key == "left" then
		moveLeft()
		addNumber()
	elseif key == "down" then
		moveDown()
		addNumber()
	elseif key == "up" then
		moveUp()
		addNumber()
	end
end

-- no controla que no se una dos veces, y siempre añade número
