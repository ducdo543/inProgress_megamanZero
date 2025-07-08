PlayerLoad1SlashState = Class{__includes = BaseState}

function PlayerLoad1SlashState:init(player)
    self.entity = player 
    
    self.time_accumulate = 0 

    --attribute for energyAbsorb release slash
    self.hitbox1 = nil 
    self.hitbox2 = nil

    -- insert hitbox 
    self:insertHitbox()    
end

function PlayerLoad1SlashState:enter(params)
    self.entity:changeAnimation('load1-slash')
    -- get offset
    local anim = self.entity.currentAnimation 
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function PlayerLoad1SlashState:update(dt)
    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
        return
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash', {delay_animation = 0.07})
        self.entity:changeAnimation('special_idlewalkToDash')
        return
    end

    -- changeState when done
    self.time_accumulate = self.time_accumulate + dt
    local anim = self.entity.currentAnimation
    if self.time_accumulate >= (#anim.frames - 1) * anim.interval then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk')
            return 
        else
            self.entity:changeState('idle')
            return 
        end
    end
end

function PlayerLoad1SlashState:insertHitbox()
    local attack_id = os.clock()
    self.hitbox1 = RectangleHitbox({
        x = self.entity.direction == 'right' and self.entity.x or self.entity.x + self.entity.width - 20,
        y = self.entity.y,
        width = 20,
        height = 25,
        dx = 0,
        dy = 0,
        movement = false,
        attack_id = attack_id,
        damage = 2
    })
    table.insert(self.entity.hitboxes, self.hitbox1)

    self.hitbox2 = RectangleHitbox({
        x = self.entity.direction == 'right' and self.entity.x + 20 or self.entity.x + self.entity.width - 20 - 35,
        y = self.entity.y - 25,
        width = 35,
        height = 55,
        dx = 0,
        dy = 0,
        movement = false,
        attack_id = attack_id,
        damage = 2
    })
    table.insert(self.entity.hitboxes, self.hitbox2)
end

function PlayerLoad1SlashState:exit()
    -- finish hitbox we want
    self.hitbox1.flag_finished = true 
    self.hitbox2.flag_finished = true
end

function PlayerLoad1SlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end