PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player)
    EntityIdleState.init(self, player)
    self.entity.offsetX = 4 -- 20/5
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.entity:changeState('walk')
        -- self.entity:changeAnimation('walk-right') --maybe first frame of PlayerWalkState hasn't receive button so we must changeAnimation right here when we don't have any
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('jump')
    end

    -- check if collide
    -- ...
end
