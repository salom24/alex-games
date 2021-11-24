-- main.lua

function love.load()
  -- Time of game
  time = 0
  -- Screen size
  width, height = love.graphics.getDimensions()
  -- Load all the scenes
  scenes = {
    intro = require "source.states.intro",
    game = require "source.states.game",
    quit = require "source.states.quit"
  }
  scenes.intro:load()
  scenes.game:load()
  scenes.quit:load()
  -- Set initial scene
  currentScene = "intro"
end

function love.update(dt)
  time = time + dt
  scenes[currentScene]:update(dt)
end

function love.draw()
  scenes[currentScene]:draw()
end
