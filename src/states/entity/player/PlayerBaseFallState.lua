PlayerBaseFallState = Class{__includes = BaseState}

function PlayerBaseFallState:init(player, gravity)
    self.entity = player 
    self.gravity = gravity 
end

function PlayerBaseFallState:enter()

end

function PlayerBaseFallState:update(dt)
    self.entity.dy = self.entity.dy + self.gravity
    self.entity.y = self.entity.y + (self.entity.dy * dt)

    --double jump
    if self.entity.flag_doubleJump == true then
        if love.keyboard.isDown('z') then 
            if love.keyboard.wasPressed('x') then
                self.entity.flag_dashJump = true 
                self.entity.flag_doubleJump = false
                self.entity:changeState('jump')
                return
            end
        elseif love.keyboard.wasPressed('x') then
            self.entity.flag_doubleJump = false
            self.entity:changeState('jump')
            return
        end
    end

    -- return idle or walk when touch the ground
    if self.entity.y >= 100 then
        self.entity.y = 100
        self.entity.dy = 0
        --reset dashjump
        self.entity.flag_dashJump = false
        self.entity:changeAnimation("fall")

        -- set the player to be walk or idle 
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk')
            self.entity.flag_doubleJump = true
            return
        else
            self.entity:changeState('idle', {delay_animation = 0.14}) 
            self.entity.currentAnimation.flag_specialAnimation = true
            self.entity.flag_doubleJump = true
            return
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