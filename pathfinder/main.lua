-- Pathfinding

-- Dimensions
SIDE =30
PIX = 20

-- States of tiles
C_IDLE = {0, 0, 0, 0}
C_START = {45/255, 255/255, 0, 255/255}
C_BLOCKED = {0, 0, 0, 255/255}
C_EXPANDED = {223/255, 221/255, 154/255, 255/255}
C_LIMIT = {229/255, 255/255, 0, 255/255}
C_GOAL = {255/255, 5/255, 0, 255/255}

-- State of game
BLOCKING = 1
DELETING = 2
SOLVING = 3
SOLVED = 4
SENTENCE = {"Solve    Erase", "Solve    Block", "Solving...", "Reset"}

sqrt2 = math.sqrt(2)

-- Initial setup
function love.load()
    -- Display
    love.window.setTitle("Pathfinder")
    love.window.setMode(600, 800, {resizable=true, fullscreen=false})
    W = love.graphics.getWidth()
    H = love.graphics.getHeight()

    -- Style
    love.graphics.setFont(love.graphics.newFont("fonts/Futura.ttc", 50))
    
    -- Initial state of the game
    state = BLOCKING
    
    -- Game tiles
    tiles = {}
    for i=1,SIDE do
        for j=1,SIDE do
            -- Fill blank tiles with true
            tiles[i.."/"..j] = true 
        end
    end
    start = 1 .."/"..SIDE
    goal = SIDE.."/"..1
    
    -- Game box
    box = {}
    box.left = (W-SIDE*PIX)/2
    box.right = W-box.left
    box.bottom = (H-SIDE*PIX)/2
    box.top = H-box.bottom
    
    -- Expanded and limit tiles
    expanded = {}
    expanded[start] = {
        b = 0,
        f = math.sqrt(2*SIDE*SIDE)
    }
    limit = {[start] = expanded[start].b + expanded[start].f}
end 

-- Fuction to handle touches
function love.mousepressed(x, y, button)
    if button == 1 and (state == BLOCKING or state == DELETING) then 
        if x>box.left and x<box.right and y>box.bottom and y<box.top then
            -- Find tile touching
            local tile = math.ceil((x-box.left)/PIX).."/"..math.ceil((y-box.bottom)/PIX)
            -- If blocking, delete tile
            -- If removing, become true
            local a = state == DELETING and true or nil
            tiles[tile] = a
        end
    end
end

function love.mousemoved(x, y)
    if love.mouse.isDown(1) and (state == BLOCKING or state == DELETING) then 
        if x>box.left and x<box.right and y>box.bottom and y<box.top then
            -- Find tile touching
            local tile = math.ceil((x-box.left)/PIX).."/"..math.ceil((y-box.bottom)/PIX)
            -- If blocking, delete tile
            -- If removing, become true
            local a = state == DELETING and true or nil
            tiles[tile] = a
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        if state == BLOCKING then
            if y < box.bottom then
                if x < W/2 then
                    state = SOLVING
                else
                    state = DELETING
                end
            end
        elseif state == DELETING then
            if y < box.bottom then
                if x < W/2 then
                    state = SOLVING
                else
                    state = BLOCKING
                end
            end
        elseif state == SOLVED then
            if y < box.bottom then
                state = BLOCKING
                expanded = {}
                expanded[start] = {
                    b = 0,
                    f = math.sqrt(2*SIDE*SIDE)
                }
                limit = {[start] = expanded[start].b + expanded[start].f}
                for i=1,SIDE do
                    for j=1,SIDE do
                        -- Fill blank tiles with true
                        tiles[i.."/"..j] = true 
                    end
                end
            end
        end
    end
end

function love.resize(w, h)
    W = w
    H = h
    if box then
        box.left = (w-SIDE*PIX)/2
        box.right = w-box.left
        box.bottom = (h-SIDE*PIX)/2
        box.top = h-box.bottom
    end
end

function love.update(dt)
    if state == SOLVING then
        while state == SOLVING do
            local a = false
            local n = 4*SIDE*SIDE+1
            for k,v in pairs(limit) do
                if v < n then
                    a = k
                    n = v
                end
            end
            limit[a] = nil
            if not a then
                state = DELETING
                print("Unable to solve.")
                love.event.quit()
            elseif a == goal then 
                state = SOLVED
            else
                local x, y = string.match(a,"(%d+)/(%d+)")
                x = tonumber(x)
                y = tonumber(y)
                for i=x-1,x+1 do
                    for j=y-1,y+1 do
                        local  t = i .."/"..j
                        if tiles[t] and (limit[t] or not expanded[t]) then
                            if i~=x and j~=y then
                                    --[[
                                local n = {
                                prev = a,
                                b = expanded[a].b + sqrt2,
                                f = math.sqrt((i-SIDE)*(i-SIDE)+(j-1)*(j-1))
                                }
                                local fx = n.b + n.f
                                if limit[t] and limit[t] > fx or not expanded[t] then
                                    expanded[t] = n
                                    limit[t] = fx
                                end
                                      ]]
                            else
                                local n = {
                                prev = a,
                                b = expanded[a].b + 1,
                                f = math.sqrt((i-SIDE)*(i-SIDE)+(j-1)*(j-1))
                                }
                                local fx = n.b + n.f
                                if limit[t] and limit[t] > fx or not expanded[t] then
                                    expanded[t] = n
                                    limit[t] = fx
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


function love.draw()
    g = love.graphics
    g.setLineWidth(0.5)
    g.setBackgroundColor(1, 1, 1, 1)
    g.setColor(0, 0, 0, 1)
    g.printf("Pathfinding", 0, H-25-box.bottom/2, W, "center")
    g.printf(SENTENCE[state], 0, box.bottom/2-25, W, "center")
    for i=1,SIDE do
        for j=1,SIDE do
            local t = i.."/"..j
            if t == start then g.setColor(C_START) 
            elseif t == goal then g.setColor(C_GOAL)
            elseif limit[t] then g.setColor(C_LIMIT)
            elseif expanded[t] then g.setColor(C_EXPANDED)   
            elseif tiles[t] then g.setColor(C_IDLE)
            else g.setColor(C_BLOCKED) end
            g.rectangle("fill", box.left+(i-1)*PIX, box.bottom+(j-1)*PIX, PIX, PIX)
            g.setColor(0, 0, 0, 1)
            g.rectangle("line", box.left+(i-1)*PIX, box.bottom+(j-1)*PIX, PIX, PIX)
        end
    end
    
    if state == SOLVED then
        g.setLineWidth(4)
        g.setColor(0, 137, 255, 255)
        local t = goal
        while expanded[t].prev do
            local x1, y1 = string.match(t,"(%d+)/(%d+)")
            local x2, y2 = string.match(expanded[t].prev,"(%d+)/(%d+)")
            g.line(box.left+x1*PIX-PIX/2, box.bottom+y1*PIX-PIX/2, box.left+x2*PIX-PIX/2, box.bottom+y2*PIX-PIX/2)
            t = expanded[t].prev
        end
    end
end
