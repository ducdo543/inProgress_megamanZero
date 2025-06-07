PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
    self.entity = player
    self.gravity = gravity

    self.entity:changeAnimation('jump')

    self.entity.dy = self.entity.jump_velocity

    self.entity.offsetX = 8 -- 40/5
    self.entity.offsetY = 3 -- 15/5
end

function PlayerJumpState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    -- change special animation when almost fall,
    -- calculate fall (dy = 0) after 25 frame when gravity = 6,
    -- want almost fall is 0.07s before fall,
    -- => almost fall before fall 4.2 frames
    -- => almost fall after 20.8 (25 - 4.2) frames => .dy = -25.2
    local frames_to_almostFall = (- self.entity.jump_velocity/self.gravity) - (0.07/(dt))
    local velocityY_when_almostFall = self.entity.jump_velocity + frames_to_almostFall * self.gravity
    if self.entity.dy >= velocityY_when_almostFall then
        self.entity.currentAnimation.flag_specialAnimation = true
    end

   
    -- go into the falling state when y velocity is positive
    if self.entity.dy >= 0 then
        self.entity:changeState('fall')
    end

    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    end
end

function PlayerJumpState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end



