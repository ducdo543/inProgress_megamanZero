PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity.offsetX = 10 -- windowsize offsetX = 50 -> virtual offsetX 50 / 5 = 10
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - ENTITY_DEFS['player'].walkSpeed * dt
        self.entity:changeAnimation('walk-right')
    end
    if love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + ENTITY_DEFS['player'].walkSpeed * dt
        self.entity:changeAnimation('walk-right')
    end
end

