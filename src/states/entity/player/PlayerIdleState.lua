PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    EntityIdleState.init(self, player)
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.player:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('jump')
    end

    -- check if collide
    -- ...
end

