EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity

end

function EntityWalkState:update(dt)

end

function EntityWalkState:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(1, 1, 1)
end