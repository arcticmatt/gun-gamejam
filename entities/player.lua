local Class  = require("libs.hump.class")
local Entity = require("entities.Entity")

local Player = Class{
  __includes = Entity -- Player class inherits our Entity class
}

local directions = { up = "up", down = "down", left = "left", right = "right", still = "still" }

function Player:init(world, x, y, w, h)
  Entity.init(self, world, x, y, w, h)
  self.direction = directions.still
end

function Player:update(dt)
  self:setDirection()

  -- TODO: no boundaries
  if self:isDir(directions.up) then
    self.y = self.y - 5
  elseif self:isDir(directions.down) then
    self.y = self.y + 5
  elseif self:isDir(directions.left) then
    self.x = self.x - 5
  elseif self:isDir(directions.right) then
    self.x = self.x + 5
  end

  self.x, self.y = self.world:move(self, self.x, self.y)
end

function Player:draw()
  love.graphics.rectangle("fill", self:getRect())
end

function Player:setDirection()
  if love.keyboard.isDown("up") then self.direction = directions.up; return end
  if love.keyboard.isDown("down") then self.direction = directions.down; return end
  if love.keyboard.isDown("left") then self.direction = directions.left; return end
  if love.keyboard.isDown("right") then self.direction = directions.right; return end
  self.direction = directions.still
end

-- Helper function
function Player:isDir(dir)
  return self.direction == dir
end

return Player
