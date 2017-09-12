local entities = {
  active = true,
  world  = nil,
  entityList = {},
}

function entities:enter(world)
  self:clear()
  self.world = world
end

function entities:add(entity)
  table.insert(self.entityList, entity)
  self.world:add(entity, entity:getRect())
end

function entities:add_many(entities)
  for k, entity in pairs(entities) do
    self:add(entity)
  end
end

function entities:clear()
  self.world = nil
  self.entityList = {}
end

function entities:draw()
  for i, e in ipairs(self.entityList) do
    e:draw(i)
  end
end

function entities:update(dt)
  for i, e in ipairs(self.entityList) do
    e:update(dt, i)
  end
end

return entities
