PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity.offsetX = 6 -- windowsize offsetX = 30 -> virtual offsetX 30 / 5 = 6
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - ENTITY_DEFS['player'].walkSpeed * dt
    end
    if love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + ENTITY_DEFS['player'].walkSpeed * dt
        self.entity:changeAnimation('walk-right')
        -- print(self.entity.currentAnimation.frames[1])
    end
end

