-- this state manages when hold button (isDown)

PlayerDashState = Class{__includes = BaseState}

function PlayerDashState:init(player)
    self.entity = player

    self.entity.offsetX = 8 -- 40/5
    self.entity.offsetY = 14 -- 70/5

    self.height_idle = self.entity.height
    self.height_dash = 16          -- 80/5

    self.entity.y = self.entity.y + 10       -- window size go down 1 segment y = 50
    self.entity.height = self.height_dash

    self.time_accumulate = 0

        -- attribute to delay Animation
    self.timeAnime_accumulate = 0
    self.flag_delayAnime = false
    self.delay_animation = nil
end

function PlayerDashState:enter(params)
    if params then
        if params.delay_animation then
            self.delay_animation = params.delay_animation
            self.flag_delayAnime = true
        end
    end 

    if self.flag_delayAnime == false then
        self.entity:changeAnimation("dash")
    end
end

function PlayerDashState:update(dt)
    -- delay anime
    if self.flag_delayAnime == true then
        self.timeAnime_accumulate = self.timeAnime_accumulate + dt
        if self.timeAnime_accumulate >= self.delay_animation then 
            self.entity:changeAnimation("dash")
            self.flag_delayAnime = false
        end
    end

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
    
    -- dash distance = 67.5 -> 0.45s is max
    self.time_accumulate = self.time_accumulate + dt
    if self.time_accumulate > 67.5/self.entity.dashSpeed then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk', {delay_dashJump = 0.5})
            self.entity.y = self.entity.y - 10
            self.entity.height = self.height_idle
            return
        else
            self.entity:changeState('idle', {delay_dashJump = 0.5, delay_animation = 0.1})
            self.entity:changeAnimation('special_dashToIdle')
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            return
        end
    else
        self.entity.flag_dashJump = true
        -- put walk in the opposite direction while dash will change state
        if self.entity.direction == 'left' and love.keyboard.wasPressed('right') then
            self.entity:changeState('walk', {delay_dashJump = 0.5})
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            return
        elseif self.entity.direction == 'right' and love.keyboard.wasPressed('left') then
            self.entity:changeState('walk', {delay_dashJump = 0.5})
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            return
        end
    end

    -- jump
    if love.keyboard.wasPressed('x') or love.keyboard.isDown('x') then --case when press z and x simultaneously. keypressed just receive 1 key in each frame, so DashState don't know whether we also press x, so i put isDown here to cover this case
        self.entity:changeState('jump')
        self.entity.y = self.entity.y - 10 
        self.entity.height = self.height_idle
        return
    end

    -- release dash button midway
    if not love.keyboard.isDown('z') then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.entity:changeState('walk', {delay_dashJump = 0.5})
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            return
        else
            self.entity:changeState('idle', {delay_dashJump = 0.5, delay_animation = 0.1})
            self.entity:changeAnimation('special_dashToIdle')
            self.entity.y = self.entity.y - 10 
            self.entity.height = self.height_idle
            return
        end
    end

    if love.keyboard.wasPressed('v') or love.keyboard.isDown('v') then
        self.entity.y = self.entity.y - 10
        self.entity.height = self.height_idle
        self.entity:changeState('sting')
        return
    end

    if love.keyboard.wasPressed('c') or love.keyboard.isDown('c') then
        self.entity.y = self.entity.y - 10
        self.entity.height = self.height_idle
        self.entity:changeState('dash-slash')
        return
    end

end

function PlayerDashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)
end