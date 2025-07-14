PlayerLoad2SlashState = Class{__includes = BaseState}

function PlayerLoad2SlashState:init(player, gravity)
    PlayerBaseJumpState.init(self, player, gravity)

end

function PlayerLoad2SlashState:enter(params)
    self.entity:changeAnimation('dash-slash')
end

function PlayerLoad2SlashState:update(dt)
    PlayerBaseJumpState.update(self, dt)
end

function PlayerLoad2SlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end