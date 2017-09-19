local Class  = require("libs.hump.class")
local Ent = require("entities.ent")
vector = require("libs.hump.vector")

local Player = Class{
  __includes = Ent -- Player class inherits our Ent class
}

local directions = {up="up", down="down", left="left", right="right"}

function Player:init(x, y, w, h, id)
  Ent.init(self, x, y, w, h, id)
  -- All we need is input. Everything else on server
  self.kb = vector(0, 0)
end

function Player:update(dt)
  self:getInputs()
  -- TODO: send self.kb to server
end

function Player:draw()
  love.graphics.rectangle("fill", self:getRect())
end

-- Populates the input array with the keys that the player is pressing down
function Player:getInputs()
  -- Reset velocity input vector
  self.kb = vector(0, 0)
  if love.keyboard.isDown(directions.up) then self.kb.y = self.kb.y - 1; end
  if love.keyboard.isDown(directions.down) then self.kb.y = self.kb.y + 1; end
  if love.keyboard.isDown(directions.left) then self.kb.x = self.kb.x - 1; end
  if love.keyboard.isDown(directions.right) then self.kb.x = self.kb.x + 1; end

  return self.kb
end

return Player
