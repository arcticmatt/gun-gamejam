local Class  = require("libs.hump.class")
local Entity = require("entities.Entity")

local Player = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function Player:init(world, x, y, w, h)
  Entity.init(self, world, x, y, w, h)
end

function Player:update(dt)
  -- TODO
end

function Player:draw()
  -- TODO
  love.graphics.rectangle("fill", self:get_rect())
end

return Player
