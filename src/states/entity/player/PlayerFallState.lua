PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:init(player, gravity)
    self.entity = player 
    self.gravity = gravity 


    -- attribute to delay Animation
    self.timeAnime_accumulate = 0
    self.flag_delayAnime = false
    self.delay_animation = nil
end

function PlayerFallState:enter(params)
    -- delay anime
    if params then
        if params.delay_animation ~= nil then
            self.delay_animation = params.delay_animation
            self.flag_delayAnime = true
        end
    end 

    if self.flag_delayAnime == false then
        self.entity:changeAnimation("fall")
        -- get offset
        local anim = self.entity.currentAnimation
        self.entity.offsetX = anim.offsetX
        self.entity.offsetY = anim.offsetY
    end

    -- receive some attributes from previous jump state
    if params then 
        if params.flag_canAirSlash ~= nil then
            self.flag_canAirSlash = params.flag_canAirSlash
            self.hitbox1 = params.hitbox1 
            self.hitbox2 = params.hitbox2
            self.hitbox3 = params.hitbox3      
            print(self.flag_canAirSlash)   
        end
    end

end

function PlayerFallState:update(dt)
    -- delay anime
    if self.flag_delayAnime == true then
        self.timeAnime_accumulate = self.timeAnime_accumulate + dt
        if self.timeAnime_accumulate >= self.delay_animation then 
            self.flag_delayAnime = false
            self.entity:changeAnimation("fall")
            -- get offset
            local anim = self.entity.currentAnimation
            self.entity.offsetX = anim.offsetX
            self.entity.offsetY = anim.offsetY            
        end
    end

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

    -- air slash
    if self.flag_canAirSlash == true then 
        if love.keyboard.wasPressed('c') then 
            self.flag_canAirSlash = false

            --change animation
            self.entity:changeAnimation('air-slash')
            -- get offset
            local anim = self.entity.currentAnimation
            self.entity.offsetX = anim.offsetX
            self.entity.offsetY = anim.offsetY

            --insert hitbox
            self:insertHitbox()
        end
    elseif not self.flag_canAirSlash then 
        if self.hitbox1 == nil or self.hitbox1.flag_finished then 
            self.flag_canAirSlash = true 
        end 
    end
    if self.hitbox1 and self.hitbox1.flag_finished then
        if self.entity.currentAnimation.texture == 'player-air-slash' then
            self.entity:changeAnimation('fall')
            local anim = self.entity.currentAnimation
            self.entity.offsetX = anim.offsetX
            self.entity.offsetY = anim.offsetY
        end
    end 
end

function PlayerFallState:insertHitbox()
    PlayerJumpState.insertHitbox(self)  
end

function PlayerFallState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end