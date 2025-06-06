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
   
    -- go into the falling state when y velocity is positive
    if self.entity.dy >= 0 then
        self.entity:changeState('walk')
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
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(1, 1, 1)
end



