PlayerBaseJumpState = Class{__includes = BaseState}

function PlayerBaseJumpState:init(player, gravity)
    self.entity = player
    self.gravity = gravity
end

function PlayerBaseJumpState:enter()

end

function PlayerBaseJumpState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    -- double jump
    if self.entity.flag_doubleJump == true then
        if love.keyboard.isDown('z') then 
            if love.keyboard.wasPressed('x') then
                self.entity.flag_dashJump = true 
                self.entity:changeState('jump')
                self.entity.flag_doubleJump = false
                return
            end
        elseif love.keyboard.wasPressed('x') then
            self.entity:changeState('jump')
            self.entity.flag_doubleJump = false
            return
        end
    end

    -- if we don't press x anymore
    if self.entity.dy >= -130 then
        if not love.keyboard.isDown('x') then
            self.entity.dy = 0
        end
    end    

    -- press left, right
    if self.entity.flag_dashJump == true then
        self.entity.dx = self.entity.dashSpeed
    else
        self.entity.dx = self.entity.walkSpeed
    end
    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.dx * dt
    elseif love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.dx * dt
    end
end