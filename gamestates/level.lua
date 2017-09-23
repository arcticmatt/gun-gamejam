local bump      = require("libs.bump.bump")
local Gamestate = require("libs.hump.gamestate")
-- Server gives us this
local ents  = require("entities.ents")
-- ===== Entities =====
local Player = require("entities.player")

-- ===== Client stuff =====
local socket = require("socket")

-- TODO add config changing for this
-- the address and port of the server
local address, port = "localhost", 12345

local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update

local t

-- ===== Game stuff =====
local level = {}
player = nil

function level:enter()
  print("Entering level")
  -- Setting up networking
  udp = assert(socket.udp())
  udp:settimeout(0)
  udp:setpeername(address, port)
  math.randomseed(os.time())

  -- TODO: don't hardcode
  -- Sending data
  local dg = string.format("%d %s $", 0, 'spawn')
  udp:send(dg)

  -- t is a variable we use to help us with the update rate in love.update.
  t = 0

  -- Clear all existing ents
  ents:clear()
end

function level:update(dt)
  if not player then
    print('spawning player...')
    data, msg = udp:receive()

    print('data, msg = ', data, msg)
    if data then
      id, cmd, params = data:match("^(%S*) (%S*) (.*)")
      if cmd == 'spawn' then
        local x, y = params:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
        print("x, y...", x, y)
        assert(x and y)
        x, y = tonumber(x), tonumber(y)
        player = Player(x, y, 32, 32, id)
      end
    end
    return
  end

	t = t + dt -- increase t by the dt

	if t > updaterate then
    local kb = player:getInputs();
    local dg = string.format("%d %s %f %f", player.id, 'move', kb.x, kb.y)
		udp:send(dg)

    local dg = string.format("%d %s $", player.id, 'update')
		udp:send(dg)

		t = t - updaterate -- set t for the next round
	end

  repeat
    data, msg = udp:receive()

    if data then
      id, cmd, params = data:match("^(%S*) (%S*) (.*)")
      if cmd == 'move' then
        -- TODO: wrap this fucking eyesore
        local x, y = params:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
        if id == player.id then
          print("move data... ", x, y)
          player.x, player.y = tonumber(x), tonumber(y)
        else
          ents:get_entity(id).x, ents:get_entity(id).y = tonumber(x), tonumber(y)
        end
      else
        print("unrecognised command:", cmd)
      end
    elseif msg ~= 'timeout' then
			error("Network error: "..tostring(msg))
    end
	until not data

  -- TODO: update ents
end

function level:draw()
  if player then
    player:draw()
  end

  ents:draw()
end

return level
