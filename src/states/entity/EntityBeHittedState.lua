EntityBeHittedState = Class{__includes = BaseState}

function EntityBeHittedState:init(entity)
    self.entity = entity 

    self.time_accumulate = 0
end

function EntityBeHittedState:enter(params)
    self.entity:changeAnimation('beHitted')
    local anim = self.entity.currentAnimation
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function EntityBeHittedState:update(dt)
    self.time_accumulate = self.time_accumulate + dt 
    if self.time_accumulate >= 0.2 then 
        self.entity:changeState('idle')
    end
end

function EntityBeHittedState:render()
    local anim = self.entity.currentAnimation
    local angle = math.rad(-90)
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.width * 3/4 or self.entity.x + self.entity.width * 1/4), math.floor(self.entity.y + self.entity.height),
        self.entity.direction == 'left' and - angle or angle , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio, 
        math.floor((self.entity.offsetX + self.entity.width * 1/4) * 5 ), math.floor((self.entity.offsetY + self.entity.height) * 5))

    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio, self.entity.width/2, self.entity.height)


    -- love.graphics.setBlendMode("alpha")
    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

    -- love.graphics.setBlendMode("add")
    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

    -- love.graphics.setBlendMode("add")
    -- love.graphics.setColor(1, 1, 1, 1)
    -- love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
    --     math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

    -- love.graphics.setBlendMode("alpha")
    -- love.graphics.setColor(1, 1, 1, 1)
end