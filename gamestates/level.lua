local bump = require("libs.bump.bump")
local Gamestate = require("libs.hump.gamestate")
local ents = require("entities.ents") -- from server
local Player = require("entities.player")
local decoder = require("utils.decoder")
local encoder = require("utils.encoder")
local socket = require("socket")

-- TODO add config changing for this
-- the address and port of the server
local address, port = "192.168.0.10", 12345

local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update

local t

-- ===== Game stuff =====
local level = {}
local player = nil

function level:enter()
  print("Entering level")
  -- Setting up networking
  udp = assert(socket.udp())
  udp:settimeout(0)
  udp:setpeername(address, port)
  math.randomseed(os.time())

  player = nil
  send_self_spawn()

  -- t is a variable we use to help us with the update rate in love.update.
  t = 0

  -- Clear all existing ents
  ents:clear()
end

function level:update(dt)
  -- Spawn player
  if not player then
    print("receive spawn...")
    player = receive_self_spawn()
    if player then
      ents:add(player.id, player)
    end
    return
  end

  -- Update player
  -- Note: this is the only ent that updates on the client (where updating means
  -- changing some variables). All other ents update entirely based on the server.
  player:update()

  -- Increase t by the dt
	t = t + dt

  -- Send player info to server
	if t > updaterate then
    local move_info = encoder:encode_move(player)
    print(string.format('Sending move info = %s', move_info))
    udp:send(move_info)

		t = t - updaterate -- set t for the next round
	end

  repeat
    data, msg = udp:receive()

    if data then
      ent_id, cmd, params = decoder:decode_data(data)
      if cmd == 'move' then
        ents:update_state(ent_id, cmd, params)
      elseif cmd =='spawn' then -- a new player joins
        print('new player joining!')
        local x, y = params.x, params.y
        assert(x and y)
        local new_player = Player(x, y, 32, 32, ent_id)
        ents:add_new(new_player.id, new_player)
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

-- ===== Helper functions =====
function send_self_spawn()
  udp:send(encoder:encode_spawn())
end

function receive_self_spawn()
  local data, msg = udp:receive()

  if data then
    ent_id, cmd, params = decoder:decode_data(data)
    if cmd == 'spawn' then
  		local x, y = params.x, params.y
      print(string.format('Spawning player with id=%d at x=%d, y=%d', ent_id, x, y))
      assert(x and y)
      return Player(x, y, 32, 32, ent_id)
    end
  end
end

return level
