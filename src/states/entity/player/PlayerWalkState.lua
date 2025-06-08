PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity.offsetX = 10 -- windowsize offsetX = 50 -> virtual offsetX 50 / 5 = 10
    self.entity:changeAnimation('walk')
end

function PlayerWalkState:update(dt) 
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    else
        self.entity:changeState('idle')
    end

    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash')
    end
end

