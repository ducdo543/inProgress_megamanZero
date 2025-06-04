PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player({
        x = 120, y = 70,
        width = 10, height = 20,
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['fall'] = function() return PlayerFallState(self.player, self.gravityAmount) end
        }
    })

    self.player:changeState('idle')
end

function PlayState:update(dt)
    self.player:update(dt)
end

function PlayState:render()
    self.player:render()
end