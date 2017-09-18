local entities = {
  entityMap = {},
}

function entities:add(key, entity)
  self.entityMap[key] = entity
end

function entities:add_many(entities)
  for k, e in pairs(entities) do
    self:add(k, e)
  end
end

function entities:get_entity(id)
  return self.entityMap[id]
end

function entities:clear()
  self.entityMap = {}
end

function entities:draw()
  for k, e in pairs(self.entityMap) do
    e:draw(k)
  end
end

function entities:update_upd(dt)
  for k, e in pairs(self.entityMap) do
    e:update(dt, k)
  end
end

function entities:update(ent_id, x, y)
  self.entityMap[ent_id]:update(x, y)
end

function entities:send_info()
  for _, e in pairs do
    e:send_info()
  end
end

return entities
