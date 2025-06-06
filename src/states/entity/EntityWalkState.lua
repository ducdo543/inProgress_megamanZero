EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    self.entity.offsetX = 0

end

function EntityWalkState:update(dt)

end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    -- -- center rotationX position in the middle entity
    -- local rotationX = self.entity.offsetX + self.entity.width / 2

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end