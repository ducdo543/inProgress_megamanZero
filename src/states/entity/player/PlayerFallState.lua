PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:init(player, gravity)
    self.entity = player 
    self.gravity = gravity 

    self.entity:changeAnimation('fall')

    self.entity.offsetX = 8 -- 40/5
    self.entity.offsetY = 3 -- 15/5
end

function PlayerFallState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)
    if self.entity.y >= 100 then
        self.entity.y = 100
        self.entity.dy = 0

        -- set the player to be walk or idle 
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end 
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    end
end

function PlayerFallState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end