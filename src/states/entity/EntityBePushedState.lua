EntityBePushedState = Class{__includes = BaseState}

function EntityBePushedState:init(entity, gravity)
    self.entity = entity
    self.gravity = gravity

    self.entity.dy = -50
    self.entity.y = self.entity.y - 1 -- ensure after one frame, entity.y < 100
end

function EntityBePushedState:enter(params)
    self.hurtbox = params.hurtbox
    self.player = params.player

    if self.player.x + self.player.width/2 < self.entity.x + self.entity.width/2 then 
        self.entity.direction = 'left'
        self.entity.dx = 150
    else
        self.entity.direction = 'right'
        self.entity.dx = -150
    end


    self.entity:changeAnimation('beHitted')
    local anim = self.entity.currentAnimation
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function EntityBePushedState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)
    self.entity.x = self.entity.x + (self.entity.dx * dt)

    if self.entity.y >= 100 then 
        self.entity.y = 100
        self.entity.dy = 0
        self.entity.dx = 0
        self.entity:changeState('idle')
    end
end

function EntityBePushedState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

end