-- this state manages when hold button (isDown)

PlayerDashState = Class{__includes = BaseState}

function PlayerDashState:init(player)
    self.entity = player
    self.entity:changeAnimation('fall')

    self.time_accumulate = 0
end

function PlayerDashState:update(dt)
    local distance = self.entity.dashSpeed * dt
    local step = 1
    local moved = 0

    while moved < distance do 
        if self.entity.direction == 'left' then 
            self.entity.x = self.entity.x - step 
        elseif self.entity.direction == 'right' then 
            self.entity.x = self.entity.x + step 
        end
        moved = moved + step
    end
    
    -- dash 0.45s is max
    self.time_accumulate = self.time_accumulate + dt
    if self.time_accumulate > 0.45 then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk')
            return
        else
            self.entity:changeState('idle')
            return
        end
    else
        self.entity.dash_jump = true
        -- put walk in the opposite direction while dash will change state
        if self.entity.direction == 'left' and love.keyboard.wasPressed('right') then
            self.entity:changeState('walk')
        elseif self.entity.direction == 'right' and love.keyboard.wasPressed('left') then
            self.entity:changeState('walk')
        end
    end

    -- jump
    if love.keyboard.wasPressed('x') or love.keyboard.isDown('x') then --case when press z and x simultaneously. keypressed just receive 1 key in each frame, so DashState don't know whether we also press x, so i put isDown here to cover this case
        self.entity:changeState('jump')
    end

    -- release dash button midway
    if not love.keyboard.isDown('z') then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk')
        else
            self.entity:changeState('idle')
        end
    end
end

function PlayerDashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end