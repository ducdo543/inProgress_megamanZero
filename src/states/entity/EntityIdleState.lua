EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity 

    -- để sau code thêm animation
    -- self.animation

    -- self.entity.currentAnimation
end

function EntityIdleState:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(1, 1, 1)
end

    