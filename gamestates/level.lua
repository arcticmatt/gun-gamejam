local bump      = require("libs.bump.bump")
local Gamestate = require("libs.hump.gamestate")
local entities  = require("entities.Entities")
-- Entities
local Player = require("entities.player")

-- Create our Gamestate
local level = {}

function level:enter()
  entities:clear()

  -- For collisions
  self.world = bump.newWorld(64)

  -- Initialize entity stuff
  entities:enter(self.world)
  player = Player(self.world, 0, 0, 20, 20)
  entities:add(player)
end

function level:update(dt)
  -- TODO
end

function level:draw()
  entities:draw()
end

return level
