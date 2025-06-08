PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player)
    EntityIdleState.init(self, player)
    self.entity.offsetX = 8 -- 40/5

    self.timeAnime_accumulate = 0
    self.delayAnime = false
end

function PlayerIdleState:enter(params)
    if params then
        if params.delay_animation then
            self.delay_animation = params.delay_animation
            self.delayAnime = true
        end
    end 

    if self.delayAnime == false then
        self.entity:changeAnimation("idle")
    end
end
function PlayerIdleState:update(dt)
    if self.delayAnime == true then
        self.timeAnime_accumulate = self.timeAnime_accumulate + dt
        if self.timeAnime_accumulate >= self.delay_animation then 
            self.entity:changeAnimation("idle")
            self.delayAnime = false
        end
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.entity:changeState('walk')
        -- self.entity:changeAnimation('walk-right') --maybe first frame of PlayerWalkState hasn't receive button so we must changeAnimation right here when we don't have any
    end

    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash')
    end

    -- check if collide
    -- ...
end
