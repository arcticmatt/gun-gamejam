local Class = require("libs.hump.class")

local Entity = Class{}

-- Superclass of all entities
function Entity:init(x, y, w, h, id)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.id = id
end

function Entity:getRect()
  return self.x, self.y, self.w, self.h
end

function Entity:draw()
  -- Do nothing by default
end

function Entity:update(dt)
  -- Do nothing by default
end

-- TODO: tostring

return Entity
