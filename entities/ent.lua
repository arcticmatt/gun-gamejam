local Class = require("libs.hump.class")

local Ent = Class{}

-- Superclass of all entities
function Ent:init(x, y, w, h, id)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.id = id
end

function Ent:getRect()
  return self.x, self.y, self.w, self.h
end

function Ent:draw()
  -- Do nothing by default
end

function Ent:update(dt)
  -- Do nothing by default
end

function Ent:update_state(cmd, params)
  -- Do nothing by default
end

return Ent
