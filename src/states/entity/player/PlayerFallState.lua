PlayerFallState = Class{__includes = BaseState}

function PlayerFallState:init(player, gravity)
    PlayerBaseFallState.init(self, player, gravity)

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
    end

    -- receive some attributes from previous jump state
    if params then 
        if params.flag_canAirSlash ~= nil then
            self.flag_canAirSlash = params.flag_canAirSlash
            self.hitbox1 = params.hitbox1 
            self.hitbox2 = params.hitbox2
            self.hitbox3 = params.hitbox3      
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
        end
    end

    PlayerBaseFallState.update(self, dt)

    -- air slash
    if self.flag_canAirSlash == true then 
        if love.keyboard.wasPressed('c') then 
            self.flag_canAirSlash = false

            --change animation
            self.entity:changeAnimation('air-slash')

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
        end
    end 

    -- change to load2-Slash state after accumulate energy 
    if not love.keyboard.isDown('c') then 
        if self.entity.can_releaseEnergy == true then 
            self.entity:changeState('load2-slash')
            return
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

