local Class  = require("libs.hump.class")
local Entity = require("entities.Entity")
vector = require("libs.hump.vector")

local Player = Class{
  __includes = Entity -- Player class inherits our Entity class
}

local directions = { up = "up", down = "down", left = "left", right = "right" }


function Player:init(world, x, y, w, h)
  Entity.init(self, world, x, y, w, h)
  -- The distance the player moves in its direction per second
  self.baseVelocity = 300
  -- Represents the current keyboard input in terms of (x, y) movement
  self.v = vector(0, 0) 
end

function Player:update(dt)
  -- Get inputs and calculates velocity trimmed to self.baseVelocity * dt
  self:getInputs()
  self.v = self.v * self.baseVelocity * dt
  self.v:trimInplace(self.baseVelocity * dt)

  -- TODO: no boundaries
  local cols, len
  self.x, self.y, cols, len = 
    self.world:move(self, self.x + self.v.x, self.y + self.v.y)
end

function Player:draw()
  love.graphics.rectangle("fill", self:getRect())
end

-- Populates the input array with the keys that the player is pressing down
function Player:getInputs()
  -- Reset velocity input vector
  self.v = vector(0, 0)
  if love.keyboard.isDown(directions.up) then self.v.y = self.v.y - 1; end
  if love.keyboard.isDown(directions.down) then self.v.y = self.v.y + 1; end
  if love.keyboard.isDown(directions.left) then self.v.x = self.v.x - 1; end
  if love.keyboard.isDown(directions.right) then self.v.x = self.v.x + 1; end
end

return Player
