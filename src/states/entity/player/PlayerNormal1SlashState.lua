PlayerNormal1SlashState = Class{__includes = BaseState}

function PlayerNormal1SlashState:init(player)
    self.entity = player 
    
    self.time_accumulate = 0 

    --attribute for energyAbsorb release slash
    self.hitbox1 = nil 

end

function PlayerNormal1SlashState:enter(params)
    self.entity:changeAnimation('dash-slash')
    -- get offset
    local anim = self.entity.currentAnimation 
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY
end

function PlayerNormal1SlashState:update(dt)
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

function PlayerNormal1SlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end