PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    EntityWalkState.init(self, player)
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - ENTITY_DEFS['player'].walkSpeed * dt
    end
    if love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + ENTITY_DEFS['player'].walkSpeed * dt
    end
end

