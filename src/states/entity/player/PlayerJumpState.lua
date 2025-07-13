PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
    PlayerBaseJumpState.init(self, player, gravity)

    self.entity.dy = self.entity.jump_velocity

    self.time_accumulate = 0

    --attribute for air slash
    self.flag_canAirSlash = false 
    self.hitbox1 = nil 
    self.hitbox2 = nil
    self.hitbox3 = nil

    -- sometimes, we press x and c simutaneously so c can not be received when we actually go into update(dt) of jump state, so we use flag_first attemp
    if love.keyboard.wasPressed('c') then
        self.first_attemp = true
    end
end

function PlayerJumpState:enter(params)
    self.entity:changeAnimation('jump')
    -- get offset
    local anim = self.entity.currentAnimation
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function PlayerJumpState:update(dt)
    PlayerBaseJumpState.update(self, dt)

    -- change special animation when almost fall,
    -- calculate fall (dy = 0) after 25 frame when gravity = 6,
    -- want almost fall is 0.07s before fall,
    -- => almost fall before fall 4.2 frames
    -- => almost fall after 20.8 (25 - 4.2) frames => .dy = -25.2
    if self.entity.currentAnimation.name == 'player-jump' then
        local frames_to_almostFall = (- self.entity.jump_velocity/self.gravity) - (0.07/(dt))
        local velocityY_when_almostFall = self.entity.jump_velocity + frames_to_almostFall * self.gravity
        if self.entity.dy >= velocityY_when_almostFall then
            self.entity.currentAnimation.flag_specialAnimation = true
        end
    end

    -- air slash
    if self.flag_canAirSlash == true then 
        if love.keyboard.wasPressed('c') or (self.first_attemp) then 
            self.first_attemp = false 
            
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

    -- accumulate time when we're in air slash
    if self.entity.currentAnimation.texture == 'player-jump-fall' then 
        self.time_accumulate = 0
    elseif self.entity.currentAnimation.texture == 'player-air-slash' then 
        self.time_accumulate = self.time_accumulate + dt 
    end
    -- calculate delay_animation if we're in air slash
    local delay_animation = 0
    local anim = self.entity.currentAnimation
    if anim.texture == 'player-air-slash' then 
        delay_animation = (#anim.frames - 1) * anim.interval - self.time_accumulate
    end

    -- go into the falling state when y velocity is positive
    if self.entity.dy >= 0 then
        self.entity.dy = 0

        self.entity:changeState('fall', {
            delay_animation = delay_animation,
            flag_canAirSlash = self.flag_canAirSlash,
            hitbox1 = self.hitbox1,
            hitbox2 = self.hitbox2,
            hitbox3 = self.hitbox3
        })
        return 
    end
end

function PlayerJumpState:insertHitbox()
    local attack_id = os.clock()

    local anim = self.entity.currentAnimation
    local time_animation = (#anim.frames - 1) * anim.interval

    self.hitbox1 = PartCircleHitbox(function()
        return {
            cx = self.entity.x + self.entity.width/2,
            cy = self.entity.y + 15,
            radius = 22,
            start_angle = self.entity.direction == 'right' and (-140) or (140),
            cover_angle = 180,
            dx = 0,
            dy = 0,
            movement = false,
            attack_id = attack_id,
            time_disappear = time_animation,
            flag_stick = true,
            damage = 2
        }
    end)

    table.insert(self.entity.hitboxes, self.hitbox1)

end

function PlayerJumpState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end



