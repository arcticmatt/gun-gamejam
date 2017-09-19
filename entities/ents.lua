local ents = {
  entMap = {},
}

function ents:add(key, entity)
  self.entMap[key] = entity
end

function ents:add_many(ents)
  for k, e in pairs(ents) do
    self:add(k, e)
  end
end

function ents:get_entity(id)
  return self.entMap[id]
end

function ents:clear()
  self.entMap = {}
end

function ents:draw()
  for k, e in pairs(self.entMap) do
    e:draw(k)
  end
end

function ents:update(ent_id, x, y)
  self.entMap[ent_id]:update(x, y)
end

function ents:send_info()
  for _, e in pairs do
    e:send_info()
  end
end

return ents
