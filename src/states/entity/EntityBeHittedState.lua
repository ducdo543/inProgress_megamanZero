EntityBeHittedState = Class{__includes = BaseState}

function EntityBeHittedState:init(entity)
    self.entity = entity 

    self.time_accumulate = 0
end

function EntityBeHittedState:enter(params)
    self.entity:changeAnimation('beHitted')
end

function EntityBeHittedState:update(dt)
    self.time_accumulate = self.time_accumulate + dt 
    if self.time_accumulate >= 0.2 then 
        self.entity:changeState('idle')
    end
end

function EntityBeHittedState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

end