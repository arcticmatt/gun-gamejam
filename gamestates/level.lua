local Gamestate = require("libs.hump.gamestate")

-- Create our Gamestate
local level = {}

function level:draw()
  love.graphics.printf("blah blah blah level", 0,
                       love.graphics.getHeight() / 2,
                       love.graphics.getWidth(), "center")
end

return level
