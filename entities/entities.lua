local entities = {
  active = true,
  world  = nil,
  entity_list = {},
}

function entities:enter(world)
  self:clear()
  self.world = world
end

function entities:add(entity)
  table.insert(self.entity_list, entity)
  self.world:add(entity, entity:get_rect())
end

function entities:add_many(entities)
  for k, entity in pairs(entities) do
    self:add(entity)
  end
end

function entities:clear()
  self.world = nil
  self.entity_list = {}
end

function entities:draw()
  for i, e in ipairs(self.entity_list) do
    e:draw(i)
  end
end

function entities:update(dt)
  for i, e in ipairs(self.entity_list) do
    e:update(dt, i)
  end
end

return entities
