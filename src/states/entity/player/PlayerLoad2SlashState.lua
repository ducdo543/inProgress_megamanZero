PlayerLoad2SlashState = Class{__includes = BaseState}

function PlayerLoad2SlashState:init(player, gravity)
    PlayerBaseJumpState.init(self, player, gravity)

    --attribute for energyAbsorb release slash
    self.time_accumulate = 0 
    self.hitbox1 = nil
    self.hitbox2 = nil

    -- insert hitbox 
    self:insertHitbox()    
end

function PlayerLoad2SlashState:enter(params)
    self.entity:changeAnimation('load2-slash')
end

function PlayerLoad2SlashState:update(dt)
    if self.entity.dy < 0 then
        PlayerBaseJumpState.update(self, dt)

    -- fall
    elseif self.entity.dy >= 0 then 
        PlayerBaseFallState.update(self, dt)
    end

    -- changeAnimation and changeState when done slash
    self.time_accumulate = self.time_accumulate + dt 
    local anim = self.entity.currentAnimation
    if self.time_accumulate >= (#anim.frames - 1) * anim.interval then
        if self.entity.dy < 0 then 
            local current_dy = self.entity.dy
            self.entity:changeState('jump')
            self.entity.dy = current_dy
            self.entity:changeAnimation('fall')
            return
        elseif self.entity.dy >= 0 then 
            self.entity:changeState('fall')
            return
        end
    end
end

function PlayerLoad2SlashState:insertHitbox()
    local attack_id = os.clock()
    self.hitbox1 = RectangleHitbox(function()
        return {
            x = self.entity.direction == 'right' and self.entity.x or self.entity.x + self.entity.width - 20,
            y = self.entity.y - 20,
            width = 20,
            height = 50,
            dx = 0,
            dy = 0,
            movement = false,
            attack_id = attack_id,
            flag_stick = true,
            damage = 2
        }
    end)
    table.insert(self.entity.hitboxes, self.hitbox1)

    self.hitbox2 = RectangleHitbox(function()
        return {
            x = self.entity.direction == 'right' and self.entity.x + 20 or self.entity.x + self.entity.width - 20 - 20,
            y = self.entity.y - 25,
            width = 20,
            height = 55,
            dx = 0,
            dy = 0,
            movement = false,
            attack_id = attack_id,
            flag_stick = true,
            damage = 2
        }
    end)
    table.insert(self.entity.hitboxes, self.hitbox2)
end 

function PlayerLoad2SlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end

function PlayerLoad2SlashState:exit()
    -- finish hitbox we want
    self.hitbox1.flag_finished = true 
    self.hitbox2.flag_finished = true
end