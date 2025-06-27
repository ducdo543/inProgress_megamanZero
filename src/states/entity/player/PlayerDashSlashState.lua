PlayerDashSlashState = Class{__includes = BaseState}

function PlayerDashSlashState:init(player)
    self.entity = player 

    self.height_idle = self.entity.height 
    self.height_dash = 16          -- 80/5

    self.entity.y = self.entity.y + 10     -- window size go down 1 segment y = 50
    self.entity.height = self.height_dash 

    self.time_accumulate = 0 
end

function PlayerDashSlashState:enter(params)
    self.entity:changeAnimation('dash-slash')
    -- get offset
    local anim = self.entity.currentAnimation
    self.entity.offsetX = anim.offsetX
    self.entity.offsetY = anim.offsetY

    -- insert hitbox

end

function PlayerDashSlashState:update(dt)
    -- go in small steps of 1 pixel to check for collision
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

    -- dashSlash distance = 36 -> 0.24s is max
    self.time_accumulate = self.time_accumulate + dt
    if self.time_accumulate > 36/self.entity.dashSpeed then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk', {delay_dashJump = 0.5})
            self.entity.y = self.entity.y - 10
            self.entity.height = self.height_idle
            
            table.remove(self.entity.hitboxes, #self.entity.hitboxes)
            return
        else
            self.entity:changeState('idle', {delay_dashJump = 0.5, delay_animation = 0.1})
            self.entity:changeAnimation('special_dashToIdle')
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            table.remove(self.entity.hitboxes, #self.entity.hitboxes)
            return
        end    
    end

    -- jump
    if love.keyboard.wasPressed('x') or love.keyboard.isDown('x') then --case when press z and x simultaneously. keypressed just receive 1 key in each frame, so DashState don't know whether we also press x, so i put isDown here to cover this case
        self.entity:changeState('jump')
        self.entity.y = self.entity.y - 10 
        self.entity.height = self.height_idle
        table.remove(self.entity.hitboxes, #self.entity.hitboxes)
        return
    end

end

function PlayerDashSlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end