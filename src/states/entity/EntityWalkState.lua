EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
end

function EntityWalkState:enter(params)
    self.entity:changeAnimation('walk')
    local anim = self.entity.currentAnimation
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function EntityWalkState:update(dt)

end

function EntityWalkState:render()

    
    local anim = self.entity.currentAnimation
    -- -- center rotationX position in the middle entity
    -- local rotationX = self.entity.offsetX + self.entity.width / 2

    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
    
    -- love.graphics.setBlendMode("alpha")
    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
    -- love.graphics.setBlendMode("add")
    -- love.graphics.setColor(1, 1, 1, 0.7)
    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

    -- -- reset to Blend Mode alpha
    -- love.graphics.setBlendMode("alpha")

    -- love.graphics.setColor(1, 1, 1, 1)
end